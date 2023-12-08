using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;
using System.IO;
using UnityEngine.Android;
using TMPro;

public class MainMenu : MonoBehaviour
{
    [Header("Menu Buttons")]
    [SerializeField] private Button newGameButton;
    [SerializeField] private Button continueGameButton;
    [SerializeField] private Button recallButton;
    [SerializeField] private Button setButton;
    public Text startTestTxt;

    [Header("For Test")]
    [SerializeField] private TMP_InputField password;
    [SerializeField] private TMP_InputField chapter;

    private void Start()
    {
        if (!DataPersistentManager.instance.HasGameData())
        {
            continueGameButton.interactable = false;
        }

        if (!Permission.HasUserAuthorizedPermission(Permission.ExternalStorageWrite))
        {
            Permission.RequestUserPermission(Permission.ExternalStorageWrite);
        }
    }

    public void OnNewGameClicked()
    {
        DisablMenuButtons();
        // Story system
        string basePath = Application.persistentDataPath;
        var files = System.IO.Directory.GetDirectories(basePath);
        int currentFileSize = files.Length;
        string folderPath = Path.Combine(basePath, (currentFileSize + 1).ToString());

        // Test
        StreamWriter st = File.CreateText(Application.persistentDataPath + "test.txt");
        st.Write("Leah My Limerence");
        st.Close();

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
            DataPersistentManager.instance.NewGame("Kingdom");
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

    public void OnSetClicked()  //  no set scene
    {
        DisablMenuButtons();
        SceneManager.LoadSceneAsync("");
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
    }
}
