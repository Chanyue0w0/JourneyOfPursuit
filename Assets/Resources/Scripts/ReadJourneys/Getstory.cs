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
    public string showtext;//
    List<string> tales = new List<string>();//save story files
    string[] allfile;//all the files in journey folders
    public int fileindex = 0;//the number of temp file
    public int textindex = 1;//the number of temp text
    public int picindex = 0;
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
                //text and pic initialize
                textlist.Clear();
                imglist.Clear();
                textindex = 1;
                picindex = 0;
                
                fileindex++;
                //read new file
                GetTextFromFile(tales[fileindex]);
                //
                string clearelement = "";
                Textlabel.text = clearelement;
                if(textlist[textindex].Contains("^")){
                    var tempsave = (textlist[textindex]).Split('^');
                    List<string> smalllist = new List<string>();
                    foreach(var part in tempsave){
                        smalllist.Add(part);
                    }
                    Textlabel.text += (smalllist[0]+"\r\n\"你選擇"+smalllist[1]+"\"");
                }
                else{
                    Textlabel.text = textlist[textindex];
                }
                picture.sprite = Resources.Load<Sprite>(imglist[picindex]);
            }
            else{
                if(textlist[textindex]=="changeImage"){
                    picindex++;
                    picture.sprite = Resources.Load<Sprite>(imglist[picindex]);
                    textindex++;
                }
                string clearelement = "";
                Textlabel.text = clearelement;
                if(textlist[textindex].Contains("^")){
                    var tempsave = (textlist[textindex]).Split('^');
                    List<string> smalllist = new List<string>();
                    foreach(var part in tempsave){
                        smalllist.Add(part);
                    }
                    Textlabel.text += (smalllist[0]+"\r\n\"你選擇"+smalllist[1]+"\"");
                }
                else{
                    Textlabel.text = textlist[textindex];
                }
                showtext = textlist[textindex];
            }
        }
    }
    void ClickLeftButton(){
        if(!(textindex==1&&fileindex==0)){
            textindex--;
            if(textindex==0&&fileindex!=0){
                //text and pic initialize
                textlist.Clear();
                imglist.Clear();

                fileindex--;
                GetTextFromFile(tales[fileindex]);
                textindex = textlist.Count-1;
                picindex = imglist.Count-1;
                string clearelement = "";
                Textlabel.text = clearelement;
                if(textlist[textindex].Contains("^")){
                    var tempsave = (textlist[textindex]).Split('^');
                    List<string> smalllist = new List<string>();
                    foreach(var part in tempsave){
                        smalllist.Add(part);
                    }
                    Textlabel.text += (smalllist[0]+"\r\n\"你選擇"+smalllist[1]+"\"");
                }
                else{
                    Textlabel.text = textlist[textindex];
                }
                picture.sprite = Resources.Load<Sprite>(imglist[picindex]);
            }
            else{
                if(textlist[textindex]=="changeImage"&&textindex!=0){
                    picindex--;
                    picture.sprite = Resources.Load<Sprite>(imglist[picindex]);
                    textindex--;
                    
                }
                string clearelement = "";
                Textlabel.text = clearelement;
                if(textlist[textindex].Contains("^")){
                    var tempsave = (textlist[textindex]).Split('^');
                    List<string> smalllist = new List<string>();
                    foreach(var part in tempsave){
                        smalllist.Add(part);
                    }
                    Textlabel.text += (smalllist[0]+"\r\n\"你選擇"+smalllist[1]+"\"");
                }
                else{
                    Textlabel.text = textlist[textindex];
                }
                showtext = textlist[textindex];
            }
        }

        /*
        if(fileindex<=tales.Count&&fileindex>=1){     
            fileindex--;    
            textlist.Clear();
            GetTextFromFile(tales[fileindex]);
        }
        */
        
    }
    void ClickExitButton(){
        fileaddress.text = "Empty";
        fileindex=0;
        textindex=1;
        picindex=0;
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
            //show initial text and picture
            Textlabel.text = clearelement;
            Textlabel.text += textlist[1];
            picture.sprite = Resources.Load<Sprite>(imglist[0]);
            
            sieve=1;   
        }
    }
    //only read file
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
        /*
        for(int i = 0;i<textlist.Count;i++){
            Textlabel.text += textlist[i];
            Textlabel.text += "\r\n\r\n";
        }
        */
    }
}
/*
#changeImage
#當主角在陌生的巷子中醒來時<br>，他感到極度困惑。他的大腦一片空白，無法回憶起自己是誰，他是如何來到這個地方的。慌張中，他注意到手中緊握著一條精美的項鍊，項鍊上掛著一個小小的寶石。\n
#changeImage
#主角緊抓著這條項鍊，他感到一種奇怪的親切感，似乎這項鍊與他的過去有某種聯繫。他陷入一個內心掙扎，不知道應該將這條項鍊戴在脖子上，還是放進口袋中。\n

#戴在脖子上

#他思考著，決定將項鍊繫在脖子上，這樣他可以隨時查看它，或者如果有人認出項鍊，或許能提供一些關於他過去的線索。\n
#主角繼續沿著陌生的巷子漫步，留意著每一個細節，希望能找到一些線索，解開自己的記憶之謎。當他經過一把路旁的躺椅時，他突然感覺到一雙眼睛注視著他。\n
#他轉頭一看，發現一位年邁的老者坐在那把躺椅上，眼神深邃，充滿智慧。老者的表情安詳，似乎對這位陌生的主角感到興趣。\n

#詢問

#主角心生一種親切感，認為這位老者或許知道些什麼。走到老者面前，微微鞠躬，然後輕聲問道：\"對不起，先生，我失去了記憶，我不知道我是誰，我是如何來到這裡的。您能幫助我嗎？”\n
#老者緩緩地轉動頭，一抹微笑浮現在他的嘴角，但他的回答卻令人困惑，\"年輕人，有時候，目光是一扇窗戶，它讓我們看到過去，也讓我們窺見未來。\"\n
#主角試圖理解老者的話語，但這似乎更增加了謎團。他再次問道，\"您說的過去和未來，是什麼意思呢？\"\n
#老者的目光再次注視遠方，他回答說，\"每一個人都有自己的故事，年輕人，有時候，我們的過去和未來在我們的眼神中都能找到答案。\"\n
#還想再詢問，老者卻已閉眼睡去。\n

#離開巷子

*/