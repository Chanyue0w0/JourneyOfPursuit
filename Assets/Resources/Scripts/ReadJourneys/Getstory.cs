using System;
using System.IO;
using System.Text;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using Newtonsoft;
using Newtonsoft.Json;

public class storys{
    public string story;
    public string image;
}

public class Getstory : MonoBehaviour
{
    public Text Textlabel;
    public Button rbutton;
    public Button lbutton;
    //public Button qbutton;


    string[] tales = Directory.GetFiles(".//Assets/Resources/journeys/journey1");
    public int storynum = 3;

    public int fileindex = 0;
    List<string> textlist = new List<string>();
    
    //List<string> imglist = new List<string>();
    private void Start(){
        rbutton.onClick.AddListener(ClickRightButton);
        lbutton.onClick.AddListener(ClickLeftButton);
        //qbutton.onClick.AddListener(ClickQuitButton);
        GetTextFromFile(tales[0]);
    }
    void ClickRightButton(){
        if(fileindex<storynum*2&&fileindex>=-2){
            fileindex+=2;
            if(fileindex==storynum*2){
                Textlabel.text = "THE END.";
            }         
            else{
                textlist.Clear();
                GetTextFromFile(tales[fileindex]);
            }
        }
    }
    void ClickLeftButton(){
        if(fileindex<=storynum*2&&fileindex>=2){     
            fileindex-=2;    
            textlist.Clear();
            GetTextFromFile(tales[fileindex]);
        }
    }

    /*
    void ClickQuitButton(){

    }
    */
    private void Update(){

    }
    private void GetTextFromFile(string Path){
        StreamReader r = new StreamReader(Path);
        string json = r.ReadToEnd();
        var desjson = JsonConvert.DeserializeObject<storys>(json);
        
        var tempsave = (desjson.story).Split('#');
        foreach(var words in tempsave){
            textlist.Add(words);
        }
        string clearelement = "";
        Textlabel.text = clearelement;
        for(int i = 0;i<textlist.Count;i++){
            Textlabel.text += textlist[i];
            Textlabel.text += "\r\n\r\n";
        }
        /*
        tempsave = (desjson.image).Split('#');
        foreach(var pic in tempsave)
            imglist.Add(pic);
        */
    }
}
