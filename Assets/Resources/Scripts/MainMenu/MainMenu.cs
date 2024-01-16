using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;
using System.IO;
using UnityEngine.Android;
using TMPro;
using UnityEngine.Assertions.Must;

public class MainMenu : MonoBehaviour
{
    [Header("Menu Buttons")]
    [SerializeField] private Button newGameButton;
    [SerializeField] private Button continueGameButton;
    [SerializeField] private Button recallButton;
    [SerializeField] private Button setButton;
    [SerializeField] private Button achButton;
    public Text startTestTxt;

    [Header("Menu Panel")]
    [SerializeField] private GameObject setPanel;
    [SerializeField] private GameObject crewPanel;
    [SerializeField] private Slider volumeSlider;
    [SerializeField] private Button mainmenuButton;
    [SerializeField] private Button switchChapterButton;
    [SerializeField] private Button crewPanelButton;
    [SerializeField] private Button textSizeRightButton;
    [SerializeField] private Button textSizeleftButton;
    [SerializeField] private TMP_Text textSize;

    [Header("For Test")]
    [SerializeField] private TMP_InputField password;
    [SerializeField] private TMP_InputField chapter;


    public string folderPath = "";
    public float dialogueTextSize = 14.0f;
    private const string TextSizeKey = "TextSize";

    public static MainMenu instance { get; private set; }

    private void Start()
    {
        if (instance != null)
        {
            Debug.LogError("Found more than one MainMenu in the scene.");
            Destroy(this.gameObject);
            return;
        }
        instance = this;



        if (!DataPersistentManager.instance.HasGameData())
        {
            continueGameButton.interactable = false;
        }

        if (!Permission.HasUserAuthorizedPermission(Permission.ExternalStorageWrite))
        {
            Permission.RequestUserPermission(Permission.ExternalStorageWrite);
        }

        AudioManager.LoadSettings();
        volumeSlider.value = AudioManager.GlobalVolume;
        volumeSlider.onValueChanged.AddListener(OnVolumeChanged);

        setPanel.SetActive(false);
        crewPanel.SetActive(false);

        if (PlayerPrefs.HasKey(TextSizeKey))
        {
            Debug.Log("has key");
            dialogueTextSize = PlayerPrefs.GetFloat(TextSizeKey);
        }
        Debug.Log("dts: " + dialogueTextSize.ToString());
        textSize.text = dialogueTextSize.ToString();

        // Achievement
        string filePath = Path.Combine(Application.persistentDataPath, "ach.txt");
        if (File.Exists(filePath))
        { 
            Debug.Log("Ach file exist: " + filePath);
        }
        else
        {
            Debug.Log("Ach file doesn't exist, creating: " + filePath);
            using (FileStream fs = File.Create(filePath))
            {
            }
        }

    }

    public void OnNewGameClicked()
    {
        DisablMenuButtons();

        // Get current time
        DateTime currentDateTime = DateTime.Now;
        int currentYear = currentDateTime.Year;
        int currentMonth = currentDateTime.Month;
        int currentDay = currentDateTime.Day;
        int currentHour = currentDateTime.Hour;
        int currentMinute = currentDateTime.Minute;
        int currentSecond = currentDateTime.Second;
        string currentTime = currentYear.ToString() + currentMonth.ToString() + currentDay.ToString() + currentHour.ToString() + currentMinute.ToString() + currentSecond.ToString();

        // Story system
        string basePath = Application.persistentDataPath;
        var files = System.IO.Directory.GetDirectories(basePath);
        //int currentFileSize = files.Length;
        folderPath = Path.Combine(basePath, (currentTime).ToString());

        Debug.LogWarning("FolderPath: " +  folderPath);

        // Test
        //StreamWriter st = File.CreateText(Application.persistentDataPath + "test.txt");
        //st.Write("Leah My Limerence");
        //st.Close();

        if (!System.IO.Directory.Exists(folderPath))
        {
            System.IO.Directory.CreateDirectory(folderPath);
            Debug.Log("Create file " + folderPath);

            startTestTxt.text += "Create file ";
        }
        else
        {
            Debug.Log("Files existed " + folderPath);
            startTestTxt.text += "Files existed ";
        }

        // create a new game - which will initialize our game data
        if (password.text == "55688")
        {
            DataPersistentManager.instance.NewGame(chapter.text);
        }
        else
        {
            DataPersistentManager.instance.NewGame("All_event");
        }
        // load the gameplay scene - which will in turn save the game because of 
        // OnSceneUnloaded() in the DataPersistenceManager
        SceneManager.LoadSceneAsync("LeahScene");
    }

    public void OnContinueGameClicked()
    {
        DisablMenuButtons();
        // load the next scene - which will in turn load the game because of 
        // OnSceneLoaded() in the DataPersistenceManager
        SceneManager.LoadSceneAsync("LeahScene");
    }

    public void OnSetClicked() 
    {
        //DisablMenuButtons();
        setPanel.SetActive(true);
        //crewPanelButton.gameObject.SetActive(true);
        //crewPanel.SetActive(false);
        //switchChapterButton.interactable = true;
    }

    public void OnAchClicked()
    {
        DisablMenuButtons();
        SceneManager.LoadSceneAsync("Achievement");
    }

    public void OnRecallClicked()
    {
        DisablMenuButtons();
        SceneManager.LoadSceneAsync("Shuangwei");
    }

    private void DisablMenuButtons()
    {
        newGameButton.interactable = false;
        continueGameButton.interactable = false;
        recallButton.interactable = false;
        setButton.interactable = false;
        achButton.interactable = false;
    }

    private void OnVolumeChanged(float volume)
    {
        AudioManager.GlobalVolume = volume;
        AudioManager.SaveSettings();
    }

    public void SetPanelClose()
    {
        if (crewPanel.activeSelf == true)
            return;
        chapter.gameObject.SetActive(false);
        password.gameObject.SetActive(false);
        crewPanel.SetActive(false);
        setPanel.SetActive(false);
        //EnableMenuButtons();
    }

    public void CrewPanelOpen()
    {
        crewPanel.SetActive(true);
        crewPanelButton.gameObject.SetActive(false);
        crewPanelButton.interactable = false;
        volumeSlider.gameObject.SetActive(false);
        volumeSlider.interactable = false;
    }

    public void CrewPanelClose()
    {
        crewPanel.SetActive(false);
        crewPanelButton.gameObject.SetActive(true);
        crewPanelButton.interactable = true;
        volumeSlider.gameObject.SetActive(true);
        volumeSlider.interactable = true;
    }

    public void SwitchChapter()
    {
        chapter.gameObject.SetActive(!chapter.gameObject.activeSelf);
        password.gameObject.SetActive(!password.gameObject.activeSelf);
    }

    public void WordSizeRight()
    {
        if (!textSizeleftButton.interactable)
            textSizeleftButton.interactable = true;

        dialogueTextSize += 1;
        textSize.text = dialogueTextSize.ToString();

        PlayerPrefs.SetFloat(TextSizeKey, dialogueTextSize);
        PlayerPrefs.Save();

        if (dialogueTextSize >= 24)
            textSizeRightButton.interactable = false;
    }

    public void WordSizeLeft()
    {
        if (!textSizeRightButton.interactable)
            textSizeRightButton.interactable = true;

        dialogueTextSize -= 1;
        textSize.text = dialogueTextSize.ToString();

        PlayerPrefs.SetFloat(TextSizeKey, dialogueTextSize);
        PlayerPrefs.Save();

        if (dialogueTextSize <= 6)
            textSizeleftButton.interactable = false;
    }
}
