using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;
using System;
using System.IO;

public class MainMenu : MonoBehaviour
{
    [Header("Menu Buttons")]
    [SerializeField] private Button newGameButton;
    [SerializeField] private Button continueGameButton;
    [SerializeField] private Button recallButton;
    [SerializeField] private Button setButton;
    public Text startTestTxt;

    private void Start()
    {
        if (!DataPersistentManager.instance.HasGameData())
        {
            continueGameButton.interactable = false;
        }
    }

    public void OnNewGameClicked()
    {
        // Story system
        string basePath = ".//Assets/Resources/journeys";
        var files = System.IO.Directory.GetDirectories(basePath);
        int currentFileSize = files.Length;
        string folderPath = Path.Combine(basePath, (currentFileSize + 1).ToString());

        if (!System.IO.Directory.Exists(folderPath))
        {
            System.IO.Directory.CreateDirectory(folderPath);
            Debug.Log("Create file " + folderPath);

            startTestTxt.text = "Create file ";
        }
        else
        {
            Debug.Log("Files existed " + folderPath);
            startTestTxt.text = "Files existed ";
        }

        //DisablMenuButtons();
        // create a new game - which will initialize our game data
        DataPersistentManager.instance.NewGame();
        // load the gameplay scene - which will in turn save the game because of 
        // OnSceneUnloaded() in the DataPersistenceManager
        startTestTxt.text += "LeahScene";
        SceneManager.LoadSceneAsync("LeahScene");
        
    }

    public void OnContinueGameClicked()
    {
        //DisablMenuButtons();
        // load the next scene - which will in turn load the game because of 
        // OnSceneLoaded() in the DataPersistenceManager
        SceneManager.LoadSceneAsync("LeahScene");
    }

    public void OnSetClicked()  //  no set scene
    {
        //DisablMenuButtons();
        SceneManager.LoadSceneAsync("");
    }

    public void OnRecallClicked()
    {
        //DisablMenuButtons();
        SceneManager.LoadSceneAsync("Shuangwei");
    }

    private void DisablMenuButtons()
    {
        newGameButton.interactable = false;
        continueGameButton.interactable = false;
    }
}
