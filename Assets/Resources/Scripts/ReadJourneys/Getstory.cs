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
    //public string Savesrc = ".//Assets/Resources/journeys/saves.json";
    public string Journeysrc = ".//Assets/Resources/journeys/journey1/";
    string[] tales = Directory.GetFiles(".//Assets/Resources/journeys/journey1");
    public int storynum = 3;
    public Text Textlabel;
    public int index = 0;
    storys show = new storys();
    private void Start(){
        
    }

    private void Update(){
        if(Input.GetMouseButtonDown(0)){
            if(index>=storynum*2){
                Textlabel.text = "THE END.";
                index=0;
            }
            else if(index<storynum*2){
                show = new storys();
                //Journeysrc = tales[index];
                GetTextFromFile(tales[index]);
                Textlabel.text = show.story+"\r\n"+show.image+"\r\n";
                index+=2;
            }
        }
    }
    
    private void GetTextFromFile(string Path){
        StreamReader r = new StreamReader(Path);
        string json = r.ReadToEnd();
        var desjson = JsonConvert.DeserializeObject<storys>(json);
        show.story = desjson.story;
        show.image = desjson.image;
    }
    

}
