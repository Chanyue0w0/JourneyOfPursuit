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

public class DialogueManager : MonoBehaviour
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
    private PlayerState player;

    // Maybe store in other place will be better?
    [Header("Variable bind with ink")]
    [SerializeField] private List<Ink.Runtime.Path> randomEvents;

    private FileManager fileManager;

    private Ink.Runtime.Story currentStory;
    private Coroutine displayLineCoroutine;

    public bool dialogueIsPlaying { get; private set; }
    public bool choicesIsMaking { get; private set; }

    private static DialogueManager instance;

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

        // Should find a better position to initialize these variables 
        player = new PlayerState();
        fileManager = new FileManager();
        randomEvents = new List<Ink.Runtime.Path>();
        inkJSON = Resources.Load<TextAsset>("Events/Aoa");
        player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
        
    }

    public static DialogueManager GetInstance()
    {
        return instance;
    }

    private void Start()
    {
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

        EnterDialogueMode(inkJSON);
    }

    private void Update()
    {
        // return right away if dialouge isn't playing
        if (!dialogueIsPlaying) 
        {
            return;
        }

        // *** Create a bool variable MakingChoices
        // handle continuing to the next line in the dialogue when submit is pressed
        if (Input.GetMouseButtonDown(0))
        {
        }

    }

    public void EnterDialogueMode(TextAsset inkJSON)
    {
        // Ink.Runtime.Story
        currentStory = new Ink.Runtime.Story(inkJSON.text);
        dialogueIsPlaying = true;
        choicesIsMaking = false;
        dialoguePanel.SetActive(true);

        dialogueVariables.StartListening(currentStory);

        // Bind with ink functions
        inkExternalFunctions.BindAll(currentStory, randomEvents, player.strength, player.agility, player.charisma);
        /*inkExternalFunctions.BindPushEvent(currentStory, randomEvents);
        inkExternalFunctions.BindGetEvent(currentStory, randomEvents);
        inkExternalFunctions.BindClearEvent(currentStory, randomEvents);
        inkExternalFunctions.BindDiceResult(currentStory, player.strength, player.agility, player.charisma);*/

        // Save Game Test
        /*if (PlayerPrefs.HasKey(saveStoryKey))
        {
            Debug.Log("has key");
            string jsonState = PlayerPrefs.GetString(saveStoryKey);
            currentStory.state.LoadJson(jsonState);
        }
        else
        {
            ContinueStory();
        }*/

        ContinueStory();
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
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
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
                    fileManager.imagePath += "#" + "Arts/Characters/" + tagValue;
                    break;
                case MORALITY_TAG:
                    player.morality += int.Parse(tagValue);
                    break;
                case BACKGROUND_TAG:
                    portraitImage.sprite = Resources.Load<Sprite>("Arts/BackGround/" + tagValue);
                    fileManager.travelogue += "#changeImage";
                    fileManager.imagePath += "#" + "Arts/BackGround/" + tagValue;
                    break;
                case HEALTHPOINT_TAG:
                    player.HP += int.Parse(tagValue);
                    player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
                    break;
                case MONEY_TAG:
                    player.money += int.Parse(tagValue);
                    player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
                    break;
                case STRENGTH_TAG:
                    player.strength += int.Parse(tagValue);
                    player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
                    break;
                case AGILITY_TAG:
                    player.agility += int.Parse(tagValue);
                    player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
                    break;
                case CHARISMA_TAG:
                    player.charisma += int.Parse(tagValue);
                    player.UpdatePlayerState(healthPointText, moneyText, strengthText, agilityText, charismaText);
                    break;
                case CHANGEFILE_TAG:
                    fileManager.fileName += 1;
                    fileManager.SaveFile(fileManager);
                    inkJSON = Resources.Load<TextAsset>("Events/" + tagValue);
                    EnterDialogueMode(inkJSON);
                    break;
                case ROLLING_TAG:
                    StartCoroutine(DiceRollingAnimation());
                    break;
                default:
                    Debug.LogWarning("Tag came in but is not currently being handled: " + tag);
                    break;
            }
        }
    }

    public IEnumerator DiceRollingAnimation()
    {
        diceIsRolling = true;
        yield return new WaitForSeconds(2);
        diceIsRolling = false;
        DiceManager.GetInstance().gameObject.SetActive(false);
        ContinueStory();
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
    public void OnApplicationQuit()
    {
        if (dialogueVariables != null)
        {
            dialogueVariables.SaveVariables();
        }

        // Save Game Test
        SaveStoryState();
    }
}   
