using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using TMPro;
using Ink.Runtime;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System;
using UnityEngine.SearchService;
using Ink.Parsed;
using System.IO;
using Unity.VisualScripting.Antlr3.Runtime;
using UnityEngine.SceneManagement;
using Unity.Mathematics;
using System.Threading;

public class DialogueManager : MonoBehaviour, IDataPersistence
{
    [Header("Params")]
    [SerializeField] private float typingSpeed = 0.06f;
    [SerializeField] private bool diceIsRolling = false;
    [SerializeField] private bool letterIsTyping = false;

    [Header("Load Globals JSON")]
    [SerializeField] private TextAsset loadGlobalsJSON;

    [Header("Dialogue UI")]
    [SerializeField] private GameObject dialoguePanel;
    [SerializeField] private TextMeshProUGUI dialogueText;
    [SerializeField] private TextMeshProUGUI displayNameText;
    [SerializeField] private Image portraitImage;

    [Header("Choices UI")]
    [SerializeField] private GameObject[] choices;
    private TextMeshProUGUI[] choicesText;

    [Header("Text File")]
    [SerializeField] private TextAsset inkJSON;

    [Header("Player Statements")]
    [SerializeField] private GameObject playerStatePanel;
    [SerializeField] private UnityEngine.UI.Text healthPointText;
    [SerializeField] private UnityEngine.UI.Text moneyText;
    [SerializeField] private UnityEngine.UI.Text strengthText;
    [SerializeField] private UnityEngine.UI.Text agilityText;
    [SerializeField] private UnityEngine.UI.Text charismaText;
    //private PlayerState player;

    [Header("Music Test")]
    [SerializeField] private GameObject dialogueManager;

    // Maybe store in other place will be better?
    [Header("Variable bind with ink")]
    [SerializeField] private List<Ink.Runtime.Path> randomEvents;

    private FileManager fileManager;
    private DialogSystem dialogueSystem;

    private Ink.Runtime.Story currentStory;
    private Coroutine displayLineCoroutine;

    public bool dialogueIsPlaying { get; private set; }
    public bool choicesIsMaking { get; private set; }

    private static DialogueManager instance;

    public int diceNum = 1;

    // Save test
    private int HP = -1;
    private int money = -1;
    private int morality = -1;
    private int strength = -1;
    private int agility = -1;
    private int charisma = -1;

    private string imagePath;
    private string storyPath;
    private string dialogueFinishedText;

    private string currBGM;
    private string currMusic;

    private const string SPEAKER_TAG = "speaker";
    private const string PORTRAIT_TAG = "portrait";
    private const string BACKGROUND_TAG = "background";
    private const string HEALTHPOINT_TAG = "health";
    private const string MONEY_TAG = "money";
    private const string MORALITY_TAG = "morality";
    private const string STRENGTH_TAG = "strength";
    private const string AGILITY_TAG = "agility";
    private const string CHARISMA_TAG = "charisma";
    private const string CHANGEFILE_TAG = "changefile";
    private const string ROLLING_TAG = "rolling";
    private const string BGM_TAG = "bgm";
    private const string MUSIC_TAG = "music";


    //Dice Panel
    [Header("Dice Panel")]
    public GameObject DicePanel;
    public UnityEngine.UI.Text  ShowType;
    public UnityEngine.UI.Text ShowDifficulty;
    public UnityEngine.UI.Text  ShowResult;
    public UnityEngine.UI.Text  ShowFinalResult;
    public Button confirmbutton;
    private bool closeconfirmbutton = false;

    private InkExternalFunctions inkExternalFunctions;
    private DialogueVariables dialogueVariables;

    private const string saveStoryKey = "INK_STORY";

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("Found more than one Dialogue Manager in the scene");
        }
        instance = this;

        inkExternalFunctions = new InkExternalFunctions();
        dialogueVariables = new DialogueVariables(loadGlobalsJSON);

        fileManager = new FileManager();
        dialogueSystem = new DialogSystem(dialogueManager);
        randomEvents = new List<Ink.Runtime.Path>();
        //inkJSON = Resources.Load<TextAsset>("Events/Aoa");
        //player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
        //UpdatePlayerState();

        //StartCoroutine(WaitForOtherInstance());
        confirmbutton.onClick.AddListener(exitfrompanel);
    }
    void exitfrompanel()
    {
        DicePanel.SetActive(false);
        closeconfirmbutton = true;
    }
    public void LoadData(GameData data)
    {
        // For Game
        this.HP = data.HP;
        this.money = data.money;
        this.morality = data.morality;
        this.strength = data.strength;
        this.agility = data.agility;
        this.charisma = data.charisma;

        this.dialogueText.text = data.dialogueText;
        this.dialogueFinishedText = data.dialogueText;

        storyPath = data.storyPath;
        inkJSON = Resources.Load<TextAsset>(data.storyPath);

        if (data.imagePath != "")
        {
            this.displayNameText.text = data.displayNameText;
            imagePath = data.imagePath;
            portraitImage.sprite = Resources.Load<Sprite>(data.imagePath);
        }
        UpdatePlayerState();

        diceIsRolling = data.diceRolling;

        // For Story
        this.fileManager.travelogue = data.travelogue;
        this.fileManager.imagePathForStory = data.imagePathForStory;
        this.fileManager.fileName = data.fileName;

        // Music
        this.currBGM = data.currBGM;
        dialogueSystem.SwitchBGM(currBGM, data.BGMTime);
        this.currMusic = data.currMusic;
        dialogueSystem.SwitchMusic(currMusic, data.musicTime);

        // Start Game
        dialogueIsPlaying = false;

        // get all of the choices text
        choicesText = new TextMeshProUGUI[choices.Length];

        DiceManager.GetInstance().gameObject.SetActive(false);

        int index = 0;
        foreach (GameObject choice in choices)
        {
            choicesText[index] = choice.GetComponentInChildren<TextMeshProUGUI>();
            index++;
        }


        EnterDialogueMode(inkJSON, false);
    }

    public void SaveData(ref GameData data)
    {
        data.HP = this.HP;
        data.money = this.money;
        data.morality = this.morality;
        data.strength = this.strength;
        data.agility = this.agility;
        data.charisma = this.charisma;

        data.displayNameText = this.displayNameText.text;
        //data.dialogueText = this.dialogueText.text;
        data.dialogueText = this.dialogueFinishedText;
        data.imagePath = this.imagePath;
        data.storyPath = this.storyPath;

        data.diceRolling = this.diceIsRolling;

        data.travelogue = this.fileManager.travelogue;
        data.imagePathForStory = this.fileManager.imagePathForStory;
        data.fileName = this.fileManager.fileName;

        data.BGMTime = dialogueSystem.BGM.time;
        data.currBGM = this.currBGM;
        data.musicTime = dialogueSystem.MUSIC.time;
        data.currMusic = this.currMusic;
    }


    public static DialogueManager GetInstance()
    {
        return instance;
    }

    private void Update()
    {
        // return right away if dialouge isn't playing
        if (!dialogueIsPlaying)
        {
            return;
        }

        if (!diceIsRolling)
        {
            DiceManager.GetInstance().gameObject.SetActive(false);
        }

    }

    public void EnterDialogueMode(TextAsset inkJSON, bool changeFile)
    {
        // Ink.Runtime.Story
        currentStory = new Ink.Runtime.Story(inkJSON.text);
        dialogueIsPlaying = true;
        choicesIsMaking = false;
        dialoguePanel.SetActive(true);
        dialogueVariables.StartListening(currentStory);

        // Bind with ink functions
        // inkExternalFunctions.BindAll(currentStory, randomEvents, player.strength, player.agility, player.charisma);
        
        inkExternalFunctions.BindAll(currentStory, randomEvents, strength, agility, charisma);

        if (PlayerPrefs.HasKey(saveStoryKey) && !changeFile)
        {
            Debug.Log("has key");
            string jsonState = PlayerPrefs.GetString(saveStoryKey);
            currentStory.state.LoadJson(jsonState);

            if (diceIsRolling)
            {
                diceIsRolling = false;
                ContinueStory();
            }
            DisplayChoices();
        }
        else
        {
            ContinueStory();
        }
    }

    private void ExitDialogueMode()
    {
        dialogueVariables.StopListening(currentStory);

        // Unbind with ink functions
        inkExternalFunctions.UnBindAll(currentStory);
        /*inkExternalFunctions.UnbindPushEvent(currentStory);
        inkExternalFunctions.UnbindGetEvent(currentStory);
        inkExternalFunctions.UnbindClearEvent(currentStory);
        inkExternalFunctions.UnbindDiceResult(currentStory);*/

        dialogueIsPlaying = false;
        //dialoguePanel.SetActive(false);
        dialogueText.text = "";


        // End add form here
        fileManager.fileName += 1;
        fileManager.SaveFile(fileManager);

        SceneManager.LoadSceneAsync("MainMenu");
        PlayerPrefs.DeleteAll();
        File.Delete(Application.persistentDataPath + "/data.txt");
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            DiceManager.GetInstance().gameObject.SetActive(false);
            // set text for the current dialogue line
            if (displayLineCoroutine != null)
            {
                StopCoroutine(displayLineCoroutine);
            }
            displayLineCoroutine = StartCoroutine(DisplayLine(currentStory.Continue()));

            // display choices, if any, for this dialogue line
            DisplayChoices();

            // handle tags
            HandleTags(currentStory.currentTags);
        }
        else
        {
            ExitDialogueMode();
        }
    }

    private IEnumerator DisplayLine(string line)
    {
        // Empty the dialogue text
        dialogueText.text = "";
        letterIsTyping = true;
        dialogueFinishedText = line;

        // display each letter one at a time
        for (int i = 0; i < line.Length; i++)
        {
            if (!letterIsTyping)
            {
                dialogueText.text = line;
                break;
            }

            if (line[i] == '<')
            {
                dialogueText.text += "\n";
                i += 3;
            }
            else
            {
                dialogueText.text += line[i];
                yield return new WaitForSeconds(typingSpeed);
            }
        }

        /*foreach (char letter in line.ToCharArray())
        {
            // if the submit button is pressed, finish up displaying the line right away
            if (!letterIsTyping)
            {
                dialogueText.text = line;
                break;
            }

            if (letter == '<')
            {
                dialogueText.text += '\n';
            }
            else
            {
                dialogueText.text += letter;
                yield return new WaitForSeconds(typingSpeed);
            }
        }*/

        letterIsTyping = false;
        fileManager.travelogue += "#" + dialogueText.text;
    }

    private void HandleTags(List<string> currentTags)
    {
        // Loop through each tag and handle it accordingly
        foreach (string tag in currentTags)
        {
            // Parse the tag
            string[] splitTag = tag.Split(':');
            if (splitTag.Length != 2)
            {
                Debug.LogError("Tag could not be appropriately parsed: " + tag);
            }

            // Remove leading and trailing spaces or specified characters from a string.
            string tagKey = splitTag[0].Trim();
            string tagValue = splitTag[1].Trim();

            // handle the tag
            switch (tagKey)
            {
                case SPEAKER_TAG:
                    displayNameText.text = tagValue;
                    break;
                case PORTRAIT_TAG:
                    portraitImage.sprite = Resources.Load<Sprite>("Arts/Characters/" + tagValue);
                    fileManager.travelogue += "#changeImage";
                    fileManager.imagePathForStory += "#" + "Arts/Characters/" + tagValue;
                    imagePath = "Arts/Characters/" + tagValue;
                    break;
                case MORALITY_TAG:
                    morality += int.Parse(tagValue);
                    break;
                case BACKGROUND_TAG:
                    portraitImage.sprite = Resources.Load<Sprite>("Arts/BackGround/" + tagValue);
                    fileManager.travelogue += "#changeImage";
                    fileManager.imagePathForStory += "#" + "Arts/BackGround/" + tagValue;
                    imagePath = "Arts/BackGround/" + tagValue;
                    break;
                case HEALTHPOINT_TAG:
                    HP += int.Parse(tagValue);
                    UpdatePlayerState();
                    break;
                case MONEY_TAG:
                    money = int.Parse(tagValue);
                    UpdatePlayerState();
                    break;
                case STRENGTH_TAG:
                    strength += int.Parse(tagValue);
                    UpdatePlayerState();
                    break;
                case AGILITY_TAG:
                    agility += int.Parse(tagValue);
                    UpdatePlayerState();
                    break;
                case CHARISMA_TAG:
                    charisma += int.Parse(tagValue);
                    UpdatePlayerState();
                    break;
                case CHANGEFILE_TAG:
                    fileManager.fileName += 1;
                    fileManager.SaveFile(fileManager);
                    storyPath = "Events/" + tagValue;
                    inkJSON = Resources.Load<TextAsset>(storyPath);
                    /*if (PlayerPrefs.HasKey(saveStoryKey))
                    {
                        PlayerPrefs.DeleteKey(saveStoryKey);
                    }*/
                    EnterDialogueMode(inkJSON, true);
                    break;
                case ROLLING_TAG:
                    StartCoroutine(DiceRollingAnimation());
                    break;
                case BGM_TAG:
                    currBGM = tagValue;
                    dialogueSystem.SwitchBGM(tagValue, 0);
                    break;
                case MUSIC_TAG:
                    currMusic = tagValue;
                    dialogueSystem.SwitchMusic(tagValue, 0);
                    break;
                default:
                    Debug.LogWarning("Tag came in but is not currently being handled: " + tag);
                    break;
            }
        }
    }

    public IEnumerator DiceRollingAnimation()
    {
        //shoe dice panel
        DicePanel.SetActive(true);
        diceIsRolling = true;
        DiceManager.GetInstance().gameObject.SetActive(true);
        DiceManager.GetInstance().anim.SetInteger("DiceResult", diceNum);
        ShowDiceResult(inkExternalFunctions.typeD,inkExternalFunctions.randvalue,inkExternalFunctions.strengthD,inkExternalFunctions.agilityD,inkExternalFunctions.charismaD,inkExternalFunctions.difficultyLevelD);
        //yield return new WaitForSeconds(2);

        while(!closeconfirmbutton)
        {
            yield return null;
        }


        diceIsRolling = false;
        closeconfirmbutton = false;
        DicePanel.SetActive(false);
        DiceManager.GetInstance().gameObject.SetActive(false);
        ContinueStory();
    }

    //
    public void ShowDiceResult(string type,int ranNum,int strength,int agility,int charisma,int difficultyLevel)
    {
        int sum = 0;
        ShowType.text = type;
        ShowDifficulty.text = difficultyLevel.ToString();
        if(type == "strength")
        {
            sum = ranNum+strength;
            ShowResult.text = ranNum.ToString() + " + " + strength.ToString() + " = " + sum.ToString();
        }
        else if(type == "agility")
        {
            sum = ranNum+agility;
            ShowResult.text = ranNum.ToString() + " + " + agility.ToString() + " = " + sum.ToString();
        }
        else
        {
            sum = ranNum + charisma;
            ShowResult.text = ranNum.ToString() + " + " + charisma.ToString() + " = " + sum.ToString();
        }

        if(sum>=difficultyLevel)
        {
            ShowFinalResult.text = "成功";
        }
        else
        {
            ShowFinalResult.text = "失敗";
        }
    }


    private void DisplayChoices()
    {
        List<Ink.Runtime.Choice> currentChoices = currentStory.currentChoices;

        // defensive check to make sure our UI can support the number of choices coming in.
        if (currentChoices.Count > choices.Length)
        {
            Debug.LogError("More choices were given than the UI can support. Number of choices given: " + currentChoices.Count);
        }

        if (currentChoices.Count > 0)
        {
            Debug.Log("current story has choices");
            choicesIsMaking = true;
        }
        else
        {
            choicesIsMaking = false;
        }

        int index = 0;
        // enable and initialize the choices up to the amount of choices for this line of dialogue
        foreach (Ink.Runtime.Choice choice in currentChoices)
        {
            choices[index].gameObject.SetActive(true);
            choicesText[index].text = choice.text;
            index++;
        }
        // go through the remaining choices the UI supports and make sure they're hidden
        for (int i = index; i < choices.Length; i++)
        {
            choices[i].gameObject.SetActive(false);
        }
        StartCoroutine(SelectFirstChoice());
    }

    private IEnumerator SelectFirstChoice()
    {
        // Event System requires we clear it first, than wait
        // for at least on frame before we set  the current selected object.
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();
        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);
    }

    public void MakeChoice(int choiceIndex)
    {
        currentStory.ChooseChoiceIndex(choiceIndex);
        print("Make choice" + choiceIndex);
        print(choicesText[choiceIndex].text);
        fileManager.travelogue += "^" + choicesText[choiceIndex].text;
        ContinueStory();
    }

    public void PlayerStateTrigger()
    {
        playerStatePanel.SetActive(!playerStatePanel.activeSelf);
    }

    public void ClickOnDialoguePanel()
    {
        if (letterIsTyping)
        {
            letterIsTyping = false;
        }
        else if (!choicesIsMaking && !diceIsRolling)
        {
            print("Continue Story");
            ContinueStory();
        }
    }

    public Ink.Runtime.Object GetVariableState(string variableName)
    {
        Ink.Runtime.Object variableValue = null;
        dialogueVariables.variables.TryGetValue(variableName, out variableValue);
        if (variableValue == null)
        {
            Debug.LogWarning("Ink variable was found to be null: " + variableName);
        }
        return variableValue;
    }

    private void SaveStoryState()
    {
        if (currentStory != null)
        {
            PlayerPrefs.SetString(saveStoryKey, currentStory.state.ToJson());
        }
    }

    // This method will get called anytime the application exits.
    // Depending on game, may want to save variable state in other places.
    public void OnApplicationPause()
    {
        if (dialogueVariables != null)
        {
            dialogueVariables.SaveVariables();
        }

        // Save Game Test
        SaveStoryState();
    }

    // Save Game Test
    public void UpdatePlayerState()
    {
        healthPointText.text = "HP: " + HP.ToString();
        moneyText.text = "Money: " + money.ToString();
        strengthText.text = "Strength: " + strength.ToString();
        agilityText.text = "Agility: " + agility.ToString();
        charismaText.text = "Charisma: " + charisma.ToString();
    }

    public void debug(string s)
    {
        dialogueText.text += s;
    }

    public void MainMenuClicked()
    {
        if (!diceIsRolling)
        {
            SceneManager.LoadSceneAsync("MainMenu");
            SaveStoryState();
            DataPersistentManager.instance.SaveGame();
        }
    }

    /*private System.Collections.IEnumerator WaitForOtherInstance()
    {
        yield return new WaitUntil(() => DialogSystem.GetInstance() != null);

        // �b�o�� OtherMonoBehaviour �w�g�Q��Ҥ�
        Debug.Log("OtherMonoBehaviour is now available!");
    }*/
}
