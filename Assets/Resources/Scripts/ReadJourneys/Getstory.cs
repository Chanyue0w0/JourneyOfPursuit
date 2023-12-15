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

//和json檔一樣配置的structure，用於抓資料的時候能抓到一樣的東西
public class storys{
    public int FolderName;//資料夾名稱（這裡沒用到）
    public int fileName;//檔案名稱（這裡沒用到）
    public string travelogue;//劇情
    public string imagePathForStory;//各個圖片位置
}

public class Getstory : MonoBehaviour
{
    [Header("遊戲內物件")]
    public Text Textlabel;//顯示文字
    public Text fileaddress;//紀錄這個故事的資料夾位置
    public Button rbutton;//向右翻的按鈕
    public Button lbutton;//向左翻的按鈕
    public Button ebutton;//退到選擇故事清單的按鈕
    public Button[] showtrigger = new Button[6];//用來確認按了哪一個按鈕
    public Image picture;//顯示圖片
    public GameObject choosewindow;//選擇故事的canvus
    public GameObject storywindow;//看故事的canvus
    
    [Header("紀錄資料用的list")]
    string[] allfile;//用來暫存這個故事資料夾裡有的檔案
    List<string> tales = new List<string>();//紀錄下這個故事裡有幾個檔案
    List<string> textlist = new List<string>();//這個檔案裡的所有劇情
    List<int> texttoimg = new List<int>();//紀錄每個text對應到的圖片
    List<string> imglist = new List<string>();//這個檔案裡的所有圖片
    
    [Header("有的沒的index")]
    public int fileindex = 0;//現在到哪一個檔案
    public int textindex = 0;//現在到哪一段劇情（同一檔案）
    public int sieve = 0;//重新讀故事資料夾的開關，確保update()裡的程式只跑一次
    public int texttoimgindex = -1;
    
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
    
    //無用途:只是用來放在button listener後面的函式
    void changestory(){
    }
    
    //處理用"#"分開的資料裡面有沒有"changeImage"或"^選項"
    void CheckContentsInTheTextlist(){
        //Debug.Log(textlist[textindex]);
        //Debug.Log(imglist[texttoimg[textindex]]);
        textlist[textindex] = textlist[textindex].Replace("<br>","\r\n");
        if(textlist[textindex].Contains("^")){
            var tempsave = (textlist[textindex]).Split("^");
            List<string> smalllist = new List<string>();
            foreach(var part in tempsave){
                smalllist.Add(part);
            }
            if(smalllist[0]!="")
                Textlabel.text = smalllist[0]+"\r\n「你選擇："+smalllist[1]+"」";
            else
                Textlabel.text = "「你選擇："+smalllist[1]+"」";
            picture.sprite = Resources.Load<Sprite>(imglist[texttoimg[textindex]]);
        }
        else{
            Textlabel.text = textlist[textindex];
            picture.sprite = Resources.Load<Sprite>(imglist[texttoimg[textindex]]);
        }
    }
    
    //按下向右翻頁
    void ClickRightButton(){
        //確認可不可以再向右翻
        if(fileindex<tales.Count&&textindex<textlist.Count&&fileindex>=-1&&textindex>=-1){
            textindex++;
            //當到檔案及故事的最後時
            if(textindex==textlist.Count&&fileindex==tales.Count-1){
                Textlabel.text = "THE END.";                
            }
            //當要換下一個檔案時
            else if(textindex==textlist.Count){
                //初始化文字和圖片
                textlist.Clear();
                imglist.Clear();
                texttoimg.Clear();
                textindex = 0;
                
                fileindex++;
                //向後換新檔案
                texttoimgindex=-1;
                GetTextFromFile(tales[fileindex]);
                string clearelement = "";
                Textlabel.text = clearelement;
                CheckContentsInTheTextlist();
            }
            //正常換頁（同檔案）
            else{
                string clearelement = "";
                Textlabel.text = clearelement;
                CheckContentsInTheTextlist();
            }
        }
    }
    
    //按下向左翻頁
    void ClickLeftButton(){
        //確認可不可以再向左翻
        if(!(textindex==0&&fileindex==0)){
            textindex--;
            //當到了劇情的最前面，但不是最前面的檔案時
            if(textindex==-1&&fileindex!=0){
                //text and pic initialize
                textlist.Clear();
                imglist.Clear();
                texttoimg.Clear();

                fileindex--;
                texttoimgindex=-1;
                GetTextFromFile(tales[fileindex]);
                textindex = textlist.Count-1;
                string clearelement = "";
                Textlabel.text = clearelement;
                CheckContentsInTheTextlist();
            }
            //正常換頁（同檔案）
            else{
                string clearelement = "";
                Textlabel.text = clearelement;
                CheckContentsInTheTextlist();
            }
        }
    }
    
    //按下跳到選擇故事畫面的button後...基本上是各個東西的初始化
    void ClickExitButton(){
        fileaddress.text = "Empty";
        fileindex=0;
        textindex=0;
        texttoimgindex=-1;
        string clearelement = "";
        Textlabel.text = clearelement;
        sieve = 0;
        textlist.Clear();
        imglist.Clear();
        texttoimg.Clear();

        storywindow.SetActive(false);
        choosewindow.SetActive(true);
    }

    private void Update(){
        //當切到這個介面時直接讀去一次資料夾裡的第一個檔案
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
            //show initial text and picture
            Textlabel.text = clearelement;
            CheckContentsInTheTextlist();

            sieve=1;   
        }
    }
    
    //把檔案裡的資料先讀進來
    private void GetTextFromFile(string Path){
        StreamReader r = new StreamReader(Path);
        string json = r.ReadToEnd();
        var desjson = JsonConvert.DeserializeObject<storys>(json);

        //read image path(用"#"來分割imagePathForStory)
        var tempsave = (desjson.imagePathForStory).Split('#');
        foreach(var pic in tempsave){
            if(pic!="")
                imglist.Add(pic);
        }

        //read file text(用"#"來分割travelogue)
        tempsave = (desjson.travelogue).Split('#');
        foreach(var words in tempsave){
            if(words != ""&&words!="\n"){
                if(words=="changeImage"){
                    texttoimgindex++;
                }
                else if(words.Contains("changeImage")){
                    texttoimgindex++;
                    texttoimg.Add(texttoimgindex);
                    
                    var tempsave2 = (words).Split("^");
                    List<string> smalllist = new List<string>();
                    foreach(var part in tempsave2){
                        smalllist.Add(part);
                    }
                    textlist.Add("^"+smalllist[1]);
                }
                else{
                    textlist.Add(words);
                    texttoimg.Add(texttoimgindex);
                    Debug.Log(words);
                }
            }
        }
    }
}