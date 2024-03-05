using System.Collections;
using System.Collections.Generic;
using System;
using System.IO;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using UnityEngine.SceneManagement;

public class ContentPresentPrototype : MonoBehaviour
{
    [Header("Content")]
    [SerializeField] private GameObject ShowPanel;
    [SerializeField] private GameObject MainMenu;

    [Header("Show Panel")]
    [SerializeField] private Image showImage;
    [SerializeField] private TextMeshProUGUI showText;
    // [SerializeField] private Button showTextBTN;

    private Dictionary<string, Button> buttonDictionary = new Dictionary<string, Button>();


    // Start is called before the first frame update
    void Start()
    {
        // ���o�ثe GameObject�]�o�Ӹ}���Ҫ��[�� GameObject�^�� transform
        Transform parentTransform = transform;

        for (int i = 0; i < parentTransform.childCount; i++)
        {
            Transform child = parentTransform.GetChild(i);
            Button button = child.GetComponent<Button>();
            if (button != null)
            {
                Debug.Log("Button " + i + " : " + button.name);
                TextMeshProUGUI[] textMeshPros = button.GetComponentsInChildren<TextMeshProUGUI>();

                foreach (TextMeshProUGUI textMeshPro in textMeshPros)
                {
                    if (textMeshPro.name == "image")
                    {
                        button.GetComponent<Image>().sprite = Resources.Load<Sprite>("Arts/Anya/" + textMeshPro.text);
                        Debug.Log("TextMeshPro " + button.name + " : " + textMeshPro.name);
                    }
                }
            }
            buttonDictionary[button.name] = button;
        }
        string filePath = Path.Combine(Application.persistentDataPath, "ach.txt");
        using (StreamReader reader = new StreamReader(filePath))
        {
            string line;
            while ((line = reader.ReadLine()) != null)
            {
                Debug.Log("What's going on?: " + line);
                if (buttonDictionary.ContainsKey(line))
                {
                    buttonDictionary[line].interactable = true;
                }
            }
        }

        Debug.Log("Finish initializing.");
        ShowPanel.SetActive(false);
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
                Debug.Log("TextMeshPro " + buttonName + " : " + textMeshPro.name);
                if (textMeshPro.name == "image")
                {
                    showImage.sprite = Resources.Load<Sprite>("Arts/Anya/" + textMeshPro.text);
                }

                if (textMeshPro.name == "text")
                {
                    showText.text = textMeshPro.text;
                }
            }
        }
        MainMenu.SetActive(false);
        ShowPanel.SetActive(true);
    }

    public void OnShowPanelClicked()
    {
        ShowPanel.SetActive(false);
        MainMenu.SetActive(true);
    }

    /*
    public void OnShowTextClick()
    {
        showText.enable = !showText.enabled;
    }
    */

    public void OnMainMenuClicked()
    {
        SceneManager.LoadSceneAsync("MainMenu");
    }
}
