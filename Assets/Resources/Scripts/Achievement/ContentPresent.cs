using System.Collections;
using System.Collections.Generic;
using System;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.SceneManagement;

public class ContentPresent : MonoBehaviour
{
    [Header("Content")]
    [SerializeField] private GameObject ShowPanel;
    [SerializeField] private GameObject ListPanel;
    [SerializeField] private GameObject MainMenu;

    [Header("Show Panel")]
    [SerializeField] private Image portraitImage;
    [SerializeField] private TextMeshProUGUI showText;

    private Dictionary<string, Button> buttonDictionary = new Dictionary<string, Button>();


    // Start is called before the first frame update
    void Start()
    {
        // 取得目前 GameObject（這個腳本所附加的 GameObject）的 transform
        Transform parentTransform = transform;

        for (int i = 0; i < parentTransform.childCount; i++)
        {
            Transform child = parentTransform.GetChild(i);
            Button button = child.GetComponent<Button>();
            if (button != null)
            {
                Debug.Log("Button 名稱: " + button.name);
            }
            buttonDictionary[button.name] = button;
        }
        string filePath = Path.Combine(Application.persistentDataPath, "ach.txt");
        using (StreamReader reader = new StreamReader(filePath))
        {
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                Debug.Log("讀取到一行: " + line);
                if (buttonDictionary.ContainsKey(line))
                {
                    buttonDictionary[line].interactable = true;
                }
            }
        }

        ShowPanel.SetActive(false);
        ListPanel.SetActive(true);
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void OnButtonClicked(string buttonName)
    {
        if (buttonDictionary.ContainsKey(buttonName))
        {
            Button clickedButton = buttonDictionary[buttonName];
            TextMeshProUGUI[] textMeshPros = clickedButton.GetComponentsInChildren<TextMeshProUGUI>();

            foreach (TextMeshProUGUI textMeshPro in textMeshPros)
            {
                Debug.Log("TextMeshPro 名稱: " + textMeshPro.name);
                if (textMeshPro.name == "image")
                {
                    portraitImage.sprite = Resources.Load<Sprite>("Arts/Ach/" + textMeshPro.text);
                }

                if (textMeshPro.name == "text")
                {
                    showText.text = textMeshPro.text;
                }
            }
        }
        MainMenu.SetActive(false);
        ListPanel.SetActive(false);
        ShowPanel.SetActive(true);
    }

    public void OnShowPanelClicked()
    {
        ShowPanel.SetActive(false);
        MainMenu.SetActive(true);
        ListPanel.SetActive(true);
    }

    public void OnMainMenuClicked()
    {
        SceneManager.LoadSceneAsync("MainMenu");
        ListPanel.SetActive(false);
    }
}
