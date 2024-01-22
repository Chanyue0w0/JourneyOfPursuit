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
    public GameObject storywindow;//顯示故事的畫面(canvus)
    public GameObject choosewindow;//讓人選擇故事的畫面
    public Button[] storys = new Button[6];//用來確認按了哪一個按鈕
    public Button[] changepage = new Button[2];//向左向右翻的按鈕
    public Button Exittomain;//回到main menu的按鈕
    public Button DeletionSwitch;//切換到刪除模式的按鈕
    public Text[] ts = new Text[6];//按鈕上的字
    public Text savefiledata;//選擇的故事的路徑
    public Text mode;//顯示現在是刪除還是閱讀模式
    public int pageindex = 0;//紀錄現在在哪一頁
    public bool DeleteMode = false;//
    List<string> tales = new List<string>();//顯示在格子裡的字
    List<FolderWithDate> filepath = new List<FolderWithDate>();//存檔案的地方
    //////////////////////////////////////////////////////////////
    
    // Start is called before the first frame update
    void Start()
    {   
        //重新讀檔
        ReloadFile();
        //預設為第0頁
        pageindex = 0;
        //預設顯示第一頁的畫面
        for(int i = 0;i<Math.Min(6,tales.Count);i++){
            ts[i].text = tales[i];
        }
        //button的初始設定
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
    //switch to delete mode
    void FileDeletion(){
        DeleteMode = !DeleteMode;
        if(DeleteMode)
            mode.text = "刪除故事";
        else
            mode.text = "目錄";
    }
    //exit to main menu
    void ExitToMainMenu(){
        SceneManager.LoadScene("MainMenu");
    }
    //重新讀取button上的text
    void ResetStory(){
        for(int i = 0;i<6;i++){
            if(tales.Count>i+pageindex)
                ts[i].text = tales[i+pageindex];
            else
                ts[i].text = "Empty";
        }
    }
    //重新讀取所有檔案放入"filepath"&"tales"
    void ReloadFile(){
        filepath.Clear();
        tales.Clear();
        var files = Directory.GetDirectories(Application.persistentDataPath);
        foreach (var file in files)
        {   
            //Hide incomplete file
            string[] allfile = Directory.GetFiles(file);
            List<string> tempsave = new List<string>();
            foreach(var inside in allfile){
                if(!inside.Contains(".meta")&&!inside.Contains(".DS_Store"))
                    tempsave.Add(inside);
            }
            if(tempsave.Count()!=0){
                FolderWithDate temp = new FolderWithDate();
                temp.fileName = file;
                temp.dateTime = File.GetCreationTime(file);
                filepath.Add(temp);
            }
            //
            /*
            //origin method
            FolderWithDate temp = new FolderWithDate();
            temp.fileName = file;
            temp.dateTime = File.GetCreationTime(file);
            filepath.Add(temp);
            */
        }
        filepath.Sort((x,y)=>DateTime.Compare(x.dateTime,y.dateTime));

        //顯示建立時間
        foreach (var file in filepath)
        {
            tales.Add((file.dateTime).ToString());
        }
        //顯示紀錄檔資料夾名稱
        /*
        for(int i = 0;i<filepath.Count;i++){
            tales.Add(i+1);
        }
        */
    }
    void selectstory1(){
        afterPressTheSelectButton(0);
    }
    void selectstory2(){
        afterPressTheSelectButton(1);
    }
    void selectstory3(){
        afterPressTheSelectButton(2);
    }
    void selectstory4(){
        afterPressTheSelectButton(3);
    }
    void selectstory5(){
        afterPressTheSelectButton(4);
    }
    void selectstory6(){
        afterPressTheSelectButton(5);
    }
    //按完按鈕後會發生的事（跳進故事或刪檔案）
    void afterPressTheSelectButton(int buttonNum){
        //buttonNum = 0 1 2 3 4 5;
        if(pageindex+buttonNum<filepath.Count){
            if(!DeleteMode){
                savefiledata.text = filepath[pageindex+buttonNum].fileName;
                storywindow.SetActive(true);
                choosewindow.SetActive(false);
            }
            else{
                Directory.Delete(filepath[pageindex+buttonNum].fileName,true);
                ReloadFile();
                if(buttonNum==0)
                    if(tales.Count%6==0&&pageindex!=0)
                        pageindex-=6;
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
