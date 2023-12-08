using System;
using System.IO;
using System.Text;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using Newtonsoft;
using Newtonsoft.Json;

public class FolderWithDate{
    public string fileName;
    public DateTime dateTime;
}
public class choosestory : MonoBehaviour
{
    public GameObject storywindow;
    public GameObject choosewindow;
    public Button[] storys = new Button[6];
    public Button[] changepage = new Button[2];
    public Button Exittomain;
    public Button DeletionSwitch;
    public Text[] ts = new Text[6];
    public Text savefiledata;
    public Text mode;
    public int pageindex = 0;
    public bool DeleteMode = false;
    List<string> tales = new List<string>();//顯示在格子裡的字
    List<FolderWithDate> filepath = new List<FolderWithDate>();//存檔案的地方
    //////////////////////////////////////////////////////////////
    
    // Start is called before the first frame update
    void Start()
    {   
        //List<FolderWithDate> filepath = new List<FolderWithDate>();
        var files = Directory.GetDirectories(Application.persistentDataPath);
        foreach (var file in files)
        {   
            FolderWithDate temp = new FolderWithDate();
            temp.fileName = file;
            temp.dateTime = File.GetCreationTime(file);
            filepath.Add(temp);
        }
        filepath.Sort((x,y)=>DateTime.Compare(x.dateTime,y.dateTime));
        
        //顯示建立時間
        foreach (var file in filepath)
        {
            tales.Add((file.dateTime).ToString());
        }
        //顯示第幾份檔
        /*
        for(int i = 0;i<filepath.Count;i++){
            tales.Add(i+1);
        }
        */
        
        pageindex = 0;
        for(int i = 0;i<Math.Min(6,tales.Count);i++){
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
        Exittomain.onClick.AddListener(ExitToMainMenu);
        DeletionSwitch.onClick.AddListener(FileDeletion);
    }
    void FileDeletion(){
        DeleteMode = !DeleteMode;
        if(DeleteMode)
            mode.text = "刪除故事";
        else
            mode.text = "～～目錄～～";
    }
    void ExitToMainMenu(){
        SceneManager.LoadScene("MainMenu");
    }
    void ResetStory(){
        for(int i = 0;i<6;i++){
            if(tales.Count>i+pageindex)
                ts[i].text = tales[i+pageindex];
            else
                ts[i].text = "Empty";
        }
        //Debug.Log(tales.Count);
        //Debug.Log(pageindex);
    }
    void selectstory1(){
        if(pageindex<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[0].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+0].fileName,true);
                tales.RemoveAt(pageindex+0);
                filepath.RemoveAt(pageindex+0);
                if(tales.Count%6==0&&pageindex!=0)
                    pageindex-=6;
                ResetStory();
            }
        }
    }
    void selectstory2(){
        if(pageindex+1<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[1].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+1].fileName,true);
                tales.RemoveAt(pageindex+1);
                filepath.RemoveAt(pageindex+1);
                ResetStory();
            }
        }
    }
    void selectstory3(){
        if(pageindex+2<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[2].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+2].fileName,true);
                tales.RemoveAt(pageindex+2);
                filepath.RemoveAt(pageindex+2);
                ResetStory();
            }
        }
    }
    void selectstory4(){
        if(pageindex+3<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[3].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+3].fileName,true);
                tales.RemoveAt(pageindex+3);
                filepath.RemoveAt(pageindex+3);
                ResetStory();
            }
        }
    }
    void selectstory5(){
        if(pageindex+4<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[4].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+4].fileName,true);
                tales.RemoveAt(pageindex+4);
                filepath.RemoveAt(pageindex+4);
                ResetStory();
            }
        }
    }
    void selectstory6(){

        if(pageindex+5<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[5].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+5].fileName,true);
                tales.RemoveAt(pageindex+5);
                filepath.RemoveAt(pageindex+5);
                ResetStory();
            }
        }
    }
    //向左翻
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
    //向右翻
    void pagech2(){
        if(tales.Count - pageindex>6)
            pageindex+=6;
        for(int i = pageindex;i<pageindex+6;i++){
            ts[i-pageindex].text = "Empty";
        }
        for(int i = pageindex;i<Math.Min(pageindex+6,tales.Count);i++){
            ts[i-pageindex].text = tales[i];
        }
    }
    // Update is called once per frame
    void Update()
    {
    }
}
