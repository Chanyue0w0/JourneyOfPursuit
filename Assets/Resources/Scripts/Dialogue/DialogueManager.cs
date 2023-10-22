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

public class DialogueManager : MonoBehaviour
{
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
    [SerializeField] private TextMeshProUGUI playerHealthPointText;
    [SerializeField] private int playerHP;
    [SerializeField] private int playerMorality;
    [SerializeField] private int playerStrength;
    [SerializeField] private int playerAgility;
    [SerializeField] private int playerCharisma;

    // Maybe store in other place will be better?
    [Header("Variable bind with ink")]
    [SerializeField] private List<Ink.Runtime.Path> randomEvents;

    private Ink.Runtime.Story currentStory;

    public bool dialogueIsPlaying { get; private set; }
    public bool choicesIsMaking { get; private set; }

    private static DialogueManager instance;

    private const string SPEAKER_TAG = "speaker";
    private const string PORTRAIT_TAG = "portrait";
    private const string BACKGROUND_TAG = "background";
    private const string HEALTHPOINT_TAG = "health";
    private const string MORALITY_TAG = "morality";
    private const string STRENGTH_TAG = "strength";
    private const string AGILITY_TAG = "agility";
    private const string CHARISMA_TAG = "charisma";

    private InkExternalFunctions inkExternalFunctions;

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("Found more than one Dialogue Manager in the scene");
        }
        instance = this;

        inkExternalFunctions = new InkExternalFunctions();

        // Should find a better position to initialize these variables 
        inkJSON = Resources.Load<TextAsset>("Events/StoryTestWithName");
        playerHP = 100;
        playerMorality = 0;
        playerStrength = 10;
        playerAgility = 10;
        playerCharisma = 10;
        playerHealthPointText.text = "Player HP: " + playerHP.ToString();
        randomEvents = new List<Ink.Runtime.Path>();
    }

    public static DialogueManager GetInstance()
    {
        return instance;
    }

    private void Start()
    {
        dialogueIsPlaying = false;
        //dialoguePanel.SetActive(false);

        // get all of the choices text
        choicesText = new TextMeshProUGUI[choices.Length];

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
            int click = ClickOn();
            print("Mouse click on " + click);
            if (click <= choices.Length && click >= 0)
            {
                print("Make choices");
                MakeChoice(click);
            }
            else if (!choicesIsMaking)
            {
                print("Continue Story");
                ContinueStory();
            }
        }

    }

    public void EnterDialogueMode(TextAsset inkJSON)
    {
        // Ink.Runtime.Story
        currentStory = new Ink.Runtime.Story(inkJSON.text);
        dialogueIsPlaying = true;
        choicesIsMaking = false;
        dialoguePanel.SetActive(true);

        // Bind with ink functions
        inkExternalFunctions.BindPushEvent(currentStory, randomEvents);
        inkExternalFunctions.BindGetEvent(currentStory, randomEvents);
        inkExternalFunctions.BindClearEvent(currentStory, randomEvents);
        inkExternalFunctions.BindDiceResult(currentStory, playerStrength, playerAgility, playerCharisma);

        ContinueStory();
    }

    private void ExitDialogueMode()
    {
        // Unbind with ink functions
        inkExternalFunctions.UnbindPushEvent(currentStory);
        inkExternalFunctions.UnbindGetEvent(currentStory);
        inkExternalFunctions.UnbindClearEvent(currentStory);
        inkExternalFunctions.UnbindDiceResult(currentStory);

        dialogueIsPlaying = false;
        //dialoguePanel.SetActive(false);
        dialogueText.text = "";
    }

    private void ContinueStory()
    {
        if (currentStory.canContinue)
        {
            // set text for the current dialogue line
            dialogueText.text = currentStory.Continue();

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
                    break;
                case HEALTHPOINT_TAG:
                    playerHP += int.Parse(tagValue);
                    playerHealthPointText.text = "Player HP:" + playerHP.ToString();
                    break;
                case MORALITY_TAG:
                    playerMorality += int.Parse(tagValue);
                    break;
                case BACKGROUND_TAG:
                    portraitImage.sprite = Resources.Load<Sprite>("Arts/BackGround/" + tagValue);
                    break;
                case STRENGTH_TAG:
                    playerStrength += int.Parse(tagValue);
                    break;
                case AGILITY_TAG:
                    playerAgility += int.Parse(tagValue);
                    break;
                case CHARISMA_TAG:
                    playerCharisma+= int.Parse(tagValue);
                    break;
                default:
                    Debug.LogWarning("Tag came in but is not currently being handled: " + tag);
                    break;
            }
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
        // Event SYstem requires we clear it first, than wait
        // for at least on frame before we set  the current selected object.
        EventSystem.current.SetSelectedGameObject(null);
        yield return new WaitForEndOfFrame();
        EventSystem.current.SetSelectedGameObject(choices[0].gameObject);
    }

    public void MakeChoice(int choiceIndex)
    {
        currentStory.ChooseChoiceIndex(choiceIndex);
        print("Make choice" + choiceIndex);
        ContinueStory();
    }

    private int ClickOn()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;

        if (Physics.Raycast(ray, out hit))
        {
            GameObject clickedObject = hit.collider.gameObject;

            switch (clickedObject.tag)
            {
                case "Choices":
                    int choiceIndex = Array.IndexOf(choices, clickedObject);
                    return choiceIndex;
            }
        }

        return -1;
    }
}   
