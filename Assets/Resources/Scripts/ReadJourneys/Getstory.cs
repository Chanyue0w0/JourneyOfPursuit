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
    public int fileName;
    public string travelogue;
    public string imagePath;
}

public class Getstory : MonoBehaviour
{
    public Text Textlabel;
    public Button rbutton;
    public Button lbutton;
    public Button ebutton;
    public Button[] showtrigger = new Button[6];
    public Image picture;

    public GameObject storywindow;
    public GameObject choosewindow;
    public Text fileaddress;
    List<string> tales = new List<string>();//save story files
    string[] allfile;//all the files in journey folders
    public int fileindex = 0;//the number of temp file
    public int textindex = 1;//the number of temp picture
    List<string> textlist = new List<string>();//save texts in one file
    List<string> imglist = new List<string>();//save images in one file

    public int sieve = 0;
    private void Start(){
        rbutton.onClick.AddListener(ClickRightButton);
        lbutton.onClick.AddListener(ClickLeftButton);
        ebutton.onClick.AddListener(ClickExitButton);
        showtrigger[0].onClick.AddListener(changestory);
        showtrigger[1].onClick.AddListener(changestory);
        showtrigger[2].onClick.AddListener(changestory);
        showtrigger[3].onClick.AddListener(changestory);
        showtrigger[4].onClick.AddListener(changestory);
        showtrigger[5].onClick.AddListener(changestory);
    }
    void changestory(){
    }
    
    void ClickRightButton(){
        if(fileindex<tales.Count&&textindex<textlist.Count&&fileindex>=-1&&textindex>=-1){
            textindex++;
            if(textindex==textlist.Count&&fileindex==tales.Count-1){
                Textlabel.text = "THE END.";                
            }
            else if(textindex==textlist.Count){
                textlist.Clear();
                imglist.Clear();
                GetTextFromFile(tales[fileindex]);
            }
        }

        /*
        if(fileindex<tales.Count&&fileindex>=-1){
            fileindex++;
            if(fileindex==tales.Count){
                Textlabel.text = "THE END.";
            }         
            else{
                textlist.Clear();
                GetTextFromFile(tales[fileindex]);
            }
        }
        */
    }
    void ClickLeftButton(){
        /*
        to-do list
        1.beware file changing
        2.check varible
        */
        

        
        if(fileindex<=tales.Count&&fileindex>=1){     
            fileindex--;    
            textlist.Clear();
            GetTextFromFile(tales[fileindex]);
        }
        
    }
    void ClickExitButton(){
        fileaddress.text = "Empty";
        fileindex=0;
        textindex=1;
        string clearelement = "";
        Textlabel.text = clearelement;
        sieve = 0;
        textlist.Clear();
        imglist.Clear();
        storywindow.SetActive(false);
        choosewindow.SetActive(true);
    }

    private void Update(){
        if(fileaddress.text!="Empty"&&sieve==0){
            tales.Clear();
            string clearelement = "";
            Textlabel.text = clearelement;
            allfile = Directory.GetFiles(fileaddress.text);
            foreach(var file in allfile){
                if(!file.Contains(".meta")&&!file.Contains(".DS_Store"))
                    tales.Add(file);
            }
            Textlabel.text = tales[0];
            GetTextFromFile(tales[0]);
            sieve=1;
        }
    }
    private void GetTextFromFile(string Path){
        StreamReader r = new StreamReader(Path);
        string json = r.ReadToEnd();
        var desjson = JsonConvert.DeserializeObject<storys>(json);
        //read file text and image
        var tempsave = (desjson.travelogue).Split('#');
        foreach(var words in tempsave){
            if(words != ""){
                string a = words.Replace("<br>","\r\n");
                textlist.Add(a);
            }
        }
        tempsave = (desjson.imagePath).Split('#');
        foreach(var pic in tempsave){
            //string b = ".//Assets/resources/"+pic;
            if(pic!="")
                imglist.Add(pic);
        }

        //show first text content(have to fix)
        string clearelement = "";
        Textlabel.text = clearelement;
        Textlabel.text += textlist[1];
        /*
        for(int i = 0;i<textlist.Count;i++){
            Textlabel.text += textlist[i];
            Textlabel.text += "\r\n\r\n";
        }
        */

        //show first image(have to fix)
        picture.sprite = Resources.Load<Sprite>(imglist[0]);
    }
}
