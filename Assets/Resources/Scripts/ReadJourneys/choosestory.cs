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

public class choosestory : MonoBehaviour
{
    public GameObject storywindow;
    public GameObject choosewindow;
    public Button[] storys = new Button[6];
    public Button[] changepage = new Button[2];
    public Text[] ts = new Text[6];
    public Text savefiledata;
    public int pageindex = 0;
    List<string> tales = new List<string>();
    List<string> filepath = new List<string>();
    //////////////////////////////////////////////////////////////
    

    // Start is called before the first frame update
    int findmin(int a,int b){
        if(a>b)
            return b;
        else
            return a;
    }
    void Start()
    {   
        var files = Directory.GetDirectories(".//Assets/Resources/journeys");
        foreach (var file in files)
        {
            string temp = file.ToString();
            filepath.Add(file);
            var tempsave = temp.Split("/");
            tales.Add(tempsave[5]);
        }
        pageindex = 0;
        for(int i = 0;i<findmin(6,tales.Count);i++){
            ts[i].text = tales[i];
        }
        /**/
        (storys[0]).onClick.AddListener(selectstory1);
        (storys[1]).onClick.AddListener(selectstory2);
        (storys[2]).onClick.AddListener(selectstory3);
        (storys[3]).onClick.AddListener(selectstory4);
        (storys[4]).onClick.AddListener(selectstory5);
        (storys[5]).onClick.AddListener(selectstory6);
        (changepage[0]).onClick.AddListener(pagech1);
        (changepage[1]).onClick.AddListener(pagech2);
    }
    void selectstory1(){
        if(pageindex<filepath.Count){
            savefiledata.text = filepath[0];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void selectstory2(){
        if(pageindex+1<filepath.Count){
            savefiledata.text = filepath[1];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void selectstory3(){
        if(pageindex+2<filepath.Count){
            savefiledata.text = filepath[2];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void selectstory4(){
        if(pageindex+3<filepath.Count){
            savefiledata.text = filepath[3];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void selectstory5(){
        if(pageindex+4<filepath.Count){
            savefiledata.text = filepath[4];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void selectstory6(){
        if(pageindex+5<filepath.Count){
            savefiledata.text = filepath[5];
            storywindow.SetActive(true);
            choosewindow.SetActive(false);
        }
    }
    void pagech1(){
        if(tales.Count>6){
            if(pageindex!=0)
                pageindex-=6;
            for(int i = pageindex;i<pageindex+6;i++){
                ts[i-pageindex].text = "Empty";
            }
            for(int i = pageindex;i<pageindex+6;i++){
                ts[i-pageindex].text = tales[i];
            }
        }
    }
    void pagech2(){
        if(tales.Count - pageindex>=6)
            pageindex+=6;
        for(int i = pageindex;i<pageindex+6;i++){
            ts[i-pageindex].text = "Empty";
        }
        for(int i = pageindex;i<findmin(pageindex+6,tales.Count);i++){
            ts[i-pageindex].text = tales[i];
        }
    }
    // Update is called once per frame
    void Update()
    {
    }
}
