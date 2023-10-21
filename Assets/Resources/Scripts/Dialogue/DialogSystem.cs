using System.Collections;
using System.Collections.Generic;
using UnityEditor.PackageManager;
using UnityEngine;
using UnityEngine.UI;

using SimpleJSON;
using System.Collections.Generic;
using UnityEngine.EventSystems;

public class DialogSystem : MonoBehaviour
{
    /*[Header("UI�ե�")]
    public Text textLabel;
    public Image faceImage;

    [Header("�奻���")]
    public TextAsset textFile;
    public Dictionary<string, string> textDict;
    public int index;
    public float textSpeed;

    // ����OSprite����
    // �p�G����ӤH�H�W����ܤ]�\���� public List<Sprite> faces�A�æb���ɤ@�}�l�N�������X�H�|����n�A��K�x�s�H�y (�]�i��ڥ��S���H�y)
    [Header("�Y��")]
    public Sprite face01;
    public Sprite face02;
    public string pathToFace01;
    public string pathToFace02;

    bool textFinished;
    bool cancelTyping;

    List<string> textList = new List<string>();

    void Awake()
    {
        GetTextFromFile(textFile, textDict);
    }

    private void OnEnable()
    {
        textFinished = true;
        StartCoroutine(SetTextUI());
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetMouseButtonDown(0) && index == textList.Count)
        {
            gameObject.SetActive(false);
            index = 0;
            return;
        }

        if (Input.GetMouseButtonDown(0))
        {
            if (textFinished && !cancelTyping)
            {
                StartCoroutine(SetTextUI());
            }
            else if (!textFinished)
            {
                cancelTyping = !cancelTyping;
            }
        }
    }

    void GetTextFromFile(TextAsset file, Dictionary<string, string> dict)
    {
        file = Resources.Load<TextAsset>("Events/testJson");
        if (file != null)
        {
            string jsonContent = file.text;
            // �ѪR JSON ���e
            var jsonNode = JSON.Parse(jsonContent);

            // �N JSON �ഫ�� Dictionary<string, string>
            dict = new Dictionary<string, string>();
            foreach (KeyValuePair<string, JSONNode> kvp in jsonNode)
            {
                dict.Add(kvp.Key, kvp.Value);
            }
        }


        textList.Clear();
        //index = 0;

        var lineData = dict["001"].Split('#');

        foreach (var line in lineData)
        {
            textList.Add(line);
        }

        index = 2;
        pathToFace01 = "Arts/Characters/Human1/faceImage";
        pathToFace02 = "Arts/Characters/Elf1/faceImage";
        face01 = Resources.Load<Sprite>(pathToFace01);
        face02 = Resources.Load<Sprite>(pathToFace02);
    }

    IEnumerator SetTextUI()
    {
        textFinished = false;
        textLabel.text = "";

        switch (textList[index][0])
        {
            case 'A':
                faceImage.sprite = face01;
                index++;
                break;
            case 'B':
                faceImage.sprite = face02;
                index++;
                break;
            default:
                break;
        }

        int letter = 0;
        while (!cancelTyping && letter < textList[index].Length - 1)
        {
            textLabel.text += textList[index][letter];
            letter++;
            yield return new WaitForSeconds(textSpeed);
        }

        textLabel.text = textList[index];
        cancelTyping = false;
        textFinished = true;
        index++;
    }*/
}

