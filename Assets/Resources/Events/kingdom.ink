INCLUDE globals.ink

//1209
//set random events
~ClearEvent()
~ PushEvent(->event4)
~ PushEvent(->event5)
~ PushEvent(->event6)
~ PushEvent(->event7)
~ PushEvent(->event8)
~ PushEvent(->event9)
~ PushEvent(->event10)
~ PushEvent(->event11)
~ PushEvent(->event12)
~ temp random1 = GetEvent()
~ temp random2 = GetEvent()
~ temp random3 = GetEvent()
~ temp random4 = GetEvent()
~ temp random5 = GetEvent()

//set event in alley
~ ClearEvent()
~ PushEvent(->box_on_the_alley)
~ PushEvent(->rock_on_the_event)
~ temp alley_random1 = GetEvent()
~ ClearEvent()
~ PushEvent(->box_on_the_alley)
~ PushEvent(->rock_on_the_event)
~ temp alley_random2 = GetEvent()

//set event of find dog
~ ClearEvent()
~ PushEvent(->event1_find)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ PushEvent(->event1_no)
~ temp dog1 = GetEvent()
~ temp dog2 = GetEvent()
~ temp dog3 = GetEvent()
~ temp dog4 = GetEvent()
~ temp dog5 = GetEvent()
~ temp dog6 = GetEvent()
~ temp dog7 = GetEvent()

/////////////////////////////////////////////////////////////////////
#portrait:Node1_Born/alley #bgm:stop #music:Awaken
你醒來時，發現自己躺在一個狹窄陰暗的小巷弄裡，”這裡是……?”你感到一陣混亂。緩慢起身，晃了晃腦袋，試圖理清現在的情況。”我剛剛應該在......等等，我原本在哪裡?”你嘗試回想，卻一無所獲。
+[檢視自身]
你穿的衣服沾滿了黑灰，邊角還有些燒焦的痕跡。從口袋裡翻出了一條項鍊。正中心鑲著一顆紅寶石，看起來價值不斐。<br>你對它的存在感到困惑，卻莫名地對它有著熟悉感，似是並非第一次看到它。#portrait:Node1_Born/necklace
++[戴起項鍊]
你將項鍊戴起，開始打量起四周。
+++[探索巷子]
    ->alley_random1

+++[離開巷子]
    ->first_guy
    

//small event in alley
===box_on_the_alley===
~ alley = alley + 1
地上有個箱子。#portrait:Node1_Born/box
+[翻開]
        有一群老鼠竄出，你被嚇了一跳。#portrait:Node1_Born/mouse
    ++[繼續探索]
        ->in_alley
    ++[離開巷子]
        ->first_guy
+[路過，繼續探索]
        ->in_alley

===rock_on_the_event===
~ alley = alley + 1
石頭後面有個閃光。#portrait:Node1_Born/stone
+[翻開]
    ~money = money + 20
    你發現了金幣(金幣+20)。#money:20 #portrait:Node1_Born/coins
    ++[繼續探索]
    ->in_alley
    ++[離開巷子]
    ->first_guy
+[路過，繼續探索]
->in_alley

===in_alley===
{alley:
- 1: #portrait:Node1_Born/alley
    ->alley_random2
- 2: #portrait:Node1_Born/alley
    這裡沒有更多東西了。
    ->first_guy
}


//random events

===first_guy===
出了巷子，你看到一個人坐在箱子上休息，看起來是搬箱子的工人。#portrait:Node1_2FirstGuy/guy_on_box #music:stop #bgm:kingdom
“看你的衣服，你不是王城的人吧?怎麼會從那條巷子裡出來?”他打量一番，說道。<br>“我...我也不知道，我一醒來就在這裡了。”你告訴他你的情況。<br>他又打量了你一陣子，而後擺了擺手。
“你可以到布告欄去看看，城裡的大小事都會刊登在那裏。或者你也可以去找衛兵，你瞧，那邊就站著一個，也許他能幫你一些忙。再往前走一段路會看到一間酒吧，也許昨天在那喝太醉了，才會什麼都不記得。或者……如果運氣好的話，你會遇到吟遊詩人，他見多識廣，也許會知道些甚麼。”
他隨手拔起路邊的雜草，讓葉片浮在左手掌心，右手手指輕點，雜草隨之翻摺成各種形狀。<br>“你怎麼辦到的?”你驚訝道。//#portrait:Node1_2FirstGuy/trick
“一點小把戲罷了，還不是得在這累的要死不活。”他抱怨道，”好啦，我還要繼續搬這些貨呢，你快去吧。”<br>他搬著箱子離開。
(你要前往：)
+[布告欄]
->event1
+[找衛兵]
->event2
+[酒吧]
->event3
+[隨意走走]
->street

===event1===
~ Times = Times + 1
你來到布告欄前。<br>查看張貼的公告。#portrait:Event1_Notice/Notice_near//無法呼叫圖片
->notice
===notice===
    *[公告一]
        國王巡街，人潮眾多，請勿推擠踩踏。#portrait:Event1_Notice/Notice_near
        ->notice
    *[公告二]
        森林近期發生異變，請勿靠近。#portrait:Event1_Notice/Notice_near
        ->notice
//    *[公告三]
//        晚禱過後請勿在街上遊蕩，會有衛兵巡邏。#portrait:Event1_Notice/Notice_near
//        ->notice
    *[公告三]
        "尋寵啟示"<br> “我家的萊斯走丟了！在城門附近走失，請有發現人一定要通知我！拜託拜託！一定獻上最高的謝意給找到牠的好心人！”#portrait:Event1_Notice/dog
        這張單子上印了張狗狗的照片，一身純白的長毛，脖子上還戴著綠寶石項圈。
        ++[協助尋找]
            你走到了萊斯走失的地點。你決定四處查看。(有一定概率找到萊斯)
            ->choice
        ++[離開]
        ->street
    *[離開]
    看起來沒有跟你有關的公告。
->street

===choice===
+++[到樹叢看看]
~ dog = dog + 1
(探頭尋找)#portrait:Event1_Notice/grove
    ->find_dog
+++[查看附近農舍周圍]
~ dog = dog + 1
(探頭尋找)#portrait:Event1_Notice/farmhouse
    ->find_dog
+++[查看前方的溝渠]
~ dog = dog + 1
(探頭尋找)#portrait:Event1_Notice/ditch
    ->find_dog
+++[到巷弄找找]
~ dog = dog + 1
(探頭尋找)#portrait:Event1_Notice/alley
    ->find_dog

===event1_find===
“汪汪”，幾聲狗叫聲傳來，你快步上前。一隻大灰狗趴伏在地上，雖然跟刊登紙上的顏色不符，但脖子上的那顆綠寶石確實跟單子上的一模一樣。#portrait:Event1_Notice/dog_d
“萊斯，來。”我蹲低身子，輕喊牠的名字，怕嚇著牠。<br>聽到了熟悉的名字，萊斯慢步朝我走來。<br>隨後，我帶著牠前往單子上寫的那處豪宅。
”萊斯！”牠的主人十分驚喜，開心的大叫，”我的小白狗狗都變灰色了，在外面的這幾天辛苦你了……”，她一面輕撫著萊斯，一面向你表達著謝意。
一旁衣裝筆挺的管家向你遞來一袋金幣，”真的很感謝你的幫助，讓萊斯能回家。”<br>你開心的拿著這筆賞金離開。#money: 100
~money = money + 100
->street

===event1_no===
這裡沒有牠的蹤跡。
->choice

===find_dog===
{dog:
-1: ->dog1
-2: ->dog2
-3: ->dog3
-4: ->dog4
-5: ->dog5
-6: ->dog6
-7: ->dog7
-else: 你找了很久，還是沒看見狗狗的蹤跡。->street
}

===event2===
~ Times = Times + 1
一名衛兵站在街道邊，他穿著全身甲，筆直的站立在那。雖說天氣並不到炎熱，但被密不透風的盔甲包著還是很辛苦。#portrait:Event2_Guard/guard
{money > 5:
->event2_m_y
-else:
->event2_m_n
}
===event2_m_y===//money enough
+[替他買一杯飲料(5coins)]
~money = money - 5
    你決定替他買一杯冰涼的飲料，緩解疲勞。恰好一旁有一攤賣飲料的攤販，你向小販買了一杯亮黃色的奇妙飲品，上頭還不斷冒著氣泡。#portrait:Event2_Guard/drink_y #money: -5
    上前敲了敲衛兵的盔甲，”辛苦你了，這杯飲料給你。”<br>他眼神感激的接過那杯飲料，大口飲下。<br>“謝謝你啦，感覺我又活過來了。”他神情誇張的說。#portrait:Event2_Guard/guard
    隨後你向他說明你的失去記憶的處境。
    “嗯...…感覺事情並不單純。你先到布告欄看看好了，上面刊登了很多訊息，也許會看到有關你的尋人啟事。”他說。
    你想了想，好像也只能先這麼做。向衛兵道謝後，你按著他的指示前往布告欄。
    ->event1
+[上前詢問]
    你直接向衛兵搭話，並向他說明你失去記憶的處境。<br>“不知道不知道，”衛兵語氣不耐煩的說到，”不務正業到這裡胡說八道，你怎麼不說你是撞到牆然後失憶的。”<br>“走開走開，別來亂。”他揮手將你趕走。<br>你十分不滿。
    ++[向他發洩你的不滿]#morality:-1
        “能不能好好說話啊，活該在這裡當柱子，不，你還不如柱子，它至少還能撐起屋頂，你卻只會浪費資源還占空間！”你朝他罵道。
        “你......”<br>“我怎樣?不爽的話來打我啊。如果你這柱子可以拋開崗位追過來的話。”<br>說完這段話，你馬上轉身跑掉，留下一臉不爽的衛兵守在原地。
        ->street
    ++[不滿的離開]
        你忿忿地看了他一眼，轉身離開。
        ->street
        
===event2_m_n===//no enough money
+[上前詢問]
    你直接向衛兵搭話，並向他說明你失去記憶的處境。<br>“不知道不知道，”衛兵語氣不耐煩的說到，”不務正業到這裡胡說八道，你怎麼不說你是撞到牆然後失憶的。”<br>“走開走開，別來亂。”他揮手將你趕走。<br>你十分不滿。
    ++[向他發洩你的不滿]#morality:-1
        “能不能好好說話啊，活該在這裡當柱子，不，你還不如柱子，它至少還能撐起屋頂，你卻只會浪費資源還占空間！”你朝他罵道。
        “你......”<br>“我怎樣?不爽的話來打我啊。如果你這柱子可以拋開崗位追過來的話。”<br>說完這段話，你馬上轉身跑掉，留下一臉不爽的衛兵守在原地。
        ->street
    ++[不滿的離開]
        你忿忿地看了他一眼，轉身離開。
        ->street

===event3===
~ Times = Times + 1
你來到了酒吧。#portrait:Event3_Bar/bar #bgm:stop #music:Cheers
->bar
===bar===
酒吧喧嘩震天。
*[坐在角落]
    你找了個人少的角落坐下。耳朵不經意地捕捉到了一個關於「許願石」的傳說，正好是一群當地居民在聊天中提到的。你感到這個話題非常引人注目，並開始仔細傾聽。
    根據傳說，許願石是一個古老種族的傳世秘寶，據說擁有神奇的力量。這塊石頭被認為能夠實現人們最真誠的願望，但它的位置一直是個謎。有人說，這塊寶石被藏在附近的山區，而有人則相信它在城市的某個角落。許多人已經尋找了許願石，但似乎只有少數幸運者真正找到它，並實現了他們的願望。
    “真希望它能幫到我” 心中默默地想著。
    ->bar
*[坐在吧檯(難度17,魅力)]
    ~temp res = DiceResult(17, "charisma")
    我走到吧檯，找了個位子坐下。調酒師熟練的調起了酒。”新面孔?今天想來點什麼?”她友好的向你搭話。#portrait:Event3_Bar/bartender
    "唉，我也是一肚子疑惑，”你嘆了口氣，”一醒來，發現自己躺在無人的巷子，失去了所有的記憶，發現身上只有個神祕的項鍊……。”<br>興許是酒吧的氣氛所致，你向她分享起了我的茫然。
    他聽完了你的故事，沉思了一會兒。#rolling:0  //難度提示
    {res:
        調酒師注視著你，並遞給你一杯飲料，說道："我明白你的感受，朋友。有時生活的困難會讓我們感到無助。這杯飲料是送給你的，希望它能為你帶來一些安慰。不要擔心，我們都曾經需要幫助，這個酒吧是一個友善的地方。如果你需要聊天或者更多的幫助，我們都在這裡。"
        你接過了那杯飲料，感到一股溫暖和希望，”我並不孤單”，這個酒吧成了你在這個陌生城市尋找自我的地方。
    - else:
        調酒師卻沒有表現出同情，他皺起了眉頭，看起來有些猶豫。似是不相信你的言語。
        "我為你的經歷感到遺憾，也許你只是昨晚喝的比較多，所以才會在巷子中醒來。"他給了你一杯水。
        ”喝點水，醒醒酒吧。”
        你接過那杯水，感到有些失落，”果然沒有人會相信我的經歷。”喝完眼前的那杯水，你默默地離開了喧囂的吧台。
        }
        ->bar
*[離開]
    你離開了酒吧。#bgm:go #music:stop
    ->street

===event4===
~ Times = Times + 1
一人靠坐在廣場中央的雕像旁，他彈著豎琴，風精靈在他身周隨著歌聲起舞。#portrait:Event4_Poet/poet
“我們的王，唯一的王，<br>他征討四方，他感動上蒼
……”<br>音符乘載著他的歌詠，微風將之散布開來，穿梭於街道。
演奏結束，觀眾們紛紛散去。你上前詢問。<br>“這身衣服……很少見了呀。”他突然說道。<br>“你知道些什麼嗎?”我連忙追問。
“這是傳說中的民族的服飾，旅遊時有幸見到一次，不過現在……唉。”他搖了搖頭。<br>似是不願意多提起，他說完這段話，便收拾了東西，離開廣場。
->street

===event5===
~ Times = Times + 1
在街上漫步時，一聲微弱的貓叫聲傳進了我的耳中。抬頭朝著聲音的來源看去，有一隻貓咪蹲坐在一棵樹上，不停地喵喵叫，看起來是隻不小心爬了太高，卻下不來的小貓。#portrait:Event5_Cat/cat_tree
+[爬上樹幫他下來(難度12,力量)]
    ~temp res = DiceResult(12, "strength")
    你決定爬上樹，救下小貓。
    #rolling: 0
    {res:
        盡管這棵樹不算矮，但對你來說，爬上它並不難。手腳並用，不一會兒你爬到能搆著小貓的位子，你伸出手，緩緩接近貓咪。
        牠一開始似是有些害怕，見到我伸出手又往後退了幾步。”小貓，別怕，我是來幫你的。”我不斷地安撫牠，牠逐漸冷靜下來。
        你將貓咪放在肩膀上，讓牠抓著你的衣服。你爬下了樹。
        牠跳下你的肩膀，看了你一眼，然後輕快地跑開了，消失在街角。#portrait:Event5_Cat/cat_street
        ->street
    -else:
        “呃……現在該怎麼辦呢？”
        也許是因為餓了太久，爬到半途，你的手就沒力了。原先只有貓咪卡在樹上，現在連你也加入待救援的行列。
        底下有個穿著紫色長袍，手持木杖的女生經過。#portrait:Event5_Cat/purple
        ++[向她求救]
            “那個紫色長袍的女生！可以幫個忙嗎?”
            抬頭，她一臉詫異的看著你，”你這是......卡樹上了?”
            看到樹上的貓咪，她瞬間理解了事情來由。
            “你也太衝動了吧。”她輕笑道。手中木杖發出一道淡紫色光束，便將小貓從樹上救了下來，再來是我。
            “謝......謝啦。”有些尷尬，你姍姍的向她道謝。
            ->street
        ++[太尷尬了，不求救]
            過了一陣子，你再也支撐不住了，從樹上摔了下來。#health: -10
            ->street
            }
+[直接路過]
    我想了想，雖然有些擔心這隻小貓，但當務之急應該是先釐清我現在的狀況。於是我決定不干涉這個情況，直接離開。
    我繼續探索四周，希望能找到些關於自己的線索。
->street

===event6===
~ Times = Times + 1
看他的打扮像是個巫師，他在路邊鋪了張地毯，幾顆石頭圍成了一個奇怪的圖形，而水晶球被放在中間，他口中唸唸有詞。看起來是個占卜的巫師。”年輕人，你正在迷惘吧?要不要給你一些建議啊?”他突然向我搭話。#portrait:Event6_Divination/divination
+[無視]
    “感覺就是來招搖撞騙的”我想著。於是裝作沒有聽到，快速離開。
    ->street
    
+[占卜(難度11,力量)]
    ~temp res = DiceResult(11, "power")
    “它怎麼知道?"我有些吃驚。”你要如何幫我?<br>“過來坐著”依言走了過去。手正要放到水晶球上時，他一把撥開我的手。<br>“怎麼了嗎?” 我問道。<br>他手指搓了搓，”你以為不用代價的嗎?”<br>翻了個白眼，”我是不是誤上了賊船了”掏出口袋中的金幣，交到了占卜師的手上。<br>    “嘿嘿，這樣才對嘛”，他滿足的砸了砸嘴。#portrait:Event6_Divination/crystal
    ”來吧，手放上來。我跟你說啊，這可是歷史悠久的寶物，從我師父的師傅…”<br>“好了別廢話，快開始吧。”我不耐煩的說道。<br>“現在的年輕人啊…”它開始唸起了咒語。<br>一咬牙，它從一旁的袋子裡抓出了個盒子，裡頭躺著顆紅寶石。占卜師將它放進了那一堆石頭中，原先劇烈震盪的水晶球稍微平靜了下來。<br>看著那顆紅寶石，身上的項鍊有了反應。#rolling: 0
    {res:
        黑氣從原本剔透的水晶球冒出，震開了我和占卜師的手掌。<br>占卜師滿頭大汗，它怪叫到”你...你到底是誰!”我都使用了這顆寶石了!
        你走吧，唉，今日諸事不順啊。"<br>我一臉莫名其妙的望著他，"明明是你技術不精吧。是說，那顆紅寶石是什麼來頭?你一拿出它，我身上的項鍊突然發燙。"<br>他沉默了幾秒：難怪啊難怪，好吧，今天算我運氣差。年輕人，這顆石頭給你吧。也許未來你會需要的。
        說完話，它收拾了一地的行李，轉身離去。
    -else:
        突然間，項鍊發出了一道紅光，射進了水晶球中，原本不穩定的水晶球頓時平靜了下來。水晶球裡映出的是一團紅光，它四周圍繞著數以萬計的生物。<br>"那是…古老種族們，連傳輸中的種族都有。”占卜師突然說道。”你來頭不小啊。”他的臉色蒼白，看來剛剛的突發事件讓他受了些傷。
        +[幫助他]
            “有我能幫上忙的嗎?畢竟是我害你受傷的。”
            他苦笑道：”不用了，你若真的感到過意不去，不如替我祈禱吧。”<br>我有些愧疚，我閉上眼誠心祈禱”希望，他的傷能盡快好起來。”
            #health:-5
            (他的臉色好了許多)<br>“這顆石頭也給你吧，在未來的旅途，你會用到它的。”它將紅寶石遞給了我。<br> 剛接過它，一道紅光從項鍊中射出，紅寶石不見了，而項鍊中的紅光似乎又更亮了一些。<br>
            他一臉驚奇，"看來，我的選擇沒有錯。"他滿意的點了點頭。<br>說完話，他收拾了一地的行李，轉身離去。
            ->street
        +[直接離開]
            “這...這該不會又是你想敲詐我的詐騙手法吧!我才不會上當呢!”<br>無法理解發生自己身上的事，我驚慌的離開現場。
            ->street
            
            }

===event7===
~ Times = Times + 1
突然一顆皮球從巷子裡被扔了出來，砸到了你的頭上。#portrait:Event7_Kids/ball
你摸了摸被球擊中的頭，緩緩轉身，發現幾個好奇的小孩探頭出來，他們看起來非常年輕，充滿了童真和好奇。他們探出頭，充滿期待地看著你，並示意你把球扔回給他們。#portrait:Event7_Kids/kids
+[拋回去]
    “接著。”
    你把球拋向他們，他們接住球後開心地笑了起來，然後轉身回到巷子裡，繼續他們的遊戲。這個小插曲雖有些突然，卻使你放鬆了不少。
    ->street
+[踢走]
    你決定玩個小小的惡作劇。你把球撿了起來，頂著小孩們炙熱的目光，你把球拋了起來，大腳一踢！皮球劃出了一道又高又遠的拋物線，消失在街道的另一頭。小孩們的眼睛睃得圓圓的，驚訝地看著他們的球飛了出去。隨即大叫嘻笑著追了上去。
    球在街道上滾來滾去，小孩們開始歡笑和奔跑，忘卻了我。
    ->street

===event8===
~ Times = Times + 1
當你漫步在王城的街道上，突然經過一間高級的甜點店時，甜點的香氣佔據了整條街道。我停下腳步，透過櫥窗看到店內，發現這個地方是一家華麗的甜點店，裝潢典雅，擺放著各種精緻的點心和甜點。#portrait:Event8_Noble/store
店內的貴族們坐在精美的桌子旁，享受著下午茶時光。他們身穿華麗的服飾，戴著頭飾，舉著精緻的茶杯，輕聲交談，優雅地品味著甜點和茶。店內的燭光和花朵裝飾使氛圍顯得格外浪漫。#portrait:Event8_Noble/noble
店內的甜點櫃展示了各種精緻的點心，如水果塔、巧克力蛋糕、覆盆子夾心餅乾，以及各種口味的茶。甜點師傅們在後廚巧妙地製作這些美食，每一道點心都看起來像藝術品一般。#portrait:Event8_Noble/showcase
+[進到店裡]
你感到一陣口水流下，想要進去品嚐一些甜點。我走進店內，找一個空位，享受一個令人陶醉的下午茶體驗，並感受這個城市的奢華和優雅。<br>當你走進那家高級甜點店，被美味的甜點吸引，坐下來想品嚐一些點心時，貴族們注意到了我的到來。一些貴族的臉上顯示出鄙視和不滿。#portrait:Event8_Noble/waiter
其中一名貴族招來了店員，低聲與他們交談。店員面露尷尬，隨後向你走來，婉轉地表示貴族們對你的到來感到不滿，要求你離開。<br>你有些不滿，但又不想引起更多麻煩。站起身，順從地離開甜點店，希望在其他地方找到一個可以品味美味甜點的地方。->street
+[在外頭觀看]
你站在玻璃外看著貴族們享用，貌似是注意到了你，一些貴族的臉上顯示出鄙視和不滿，開始交頭接耳，其中一名貴族舉手招來了店員，臉色難看的與店員交談。店員姿態低下的連連點頭，隨即開門朝你走來。#portrait:Event8_Noble/waiter
"先生，請不要擋在這邊。”他說到。揮手將你趕走。
->street

===event9===
~ Times = Times + 1
陣陣喧嘩聲伴著幾聲驚呼，原來是有個街頭藝人正在進行一場引人注目的魔法表演。#portrait:Event9_Actor/magician
他站在一個小舞台上，周圍擺滿了好奇的觀眾。他舉起手中的法杖，開始念咒語，一道炫目的火焰噴射而出，形成了壯觀的火焰圈。#portrait:Event9_Actor/fire
觀眾們歡呼鼓掌，而街頭藝人的表演還在繼續。火焰炸開，變成玫瑰花瓣散落在空中，讓花瓣飄落到觀眾面前，使眾人置身於飛舞的花海中。#portrait:Event9_Actor/petal
接下來，他伸手一抓，一隻活蹦亂跳的小兔子出現在他的手上，將兔子朝天空一拋，再一彈指，兔子變成了鳥兒，在空中盤旋了一圈後，降落在一個觀看表演的孩子頭上。孩子們的眼睛閃閃發亮，雀躍的又叫又跳。#portrait:Event9_Actor/bird
街頭藝人的表演充滿驚奇和魔法元素，他不斷讓觀眾驚喜不斷，他的技巧和魔法能力令人嘆為觀止。他在整個表演中娛樂著觀眾，將這個奇幻世界的魔法之美呈現給每一位在場的人。這個奇妙的瞬間讓你感到這個世界的魔法和奇幻之處。#portrait:Event9_Actor/magician
->street

===event10===
~ Times = Times + 1
漫不經心的低頭走著，不小心撞到路人。他披著深色斗篷，臉被被長長的兜帽所遮蓋，只露出一雙深邃的眼睛。#portrait:Event10_BlackRobe/black
+[朝他大喊]
    “走路能不能小心點啊!”你朝他喊。
    他並未停下腳步，只是轉頭看了你一眼，而後繼續往前走。僅僅是這一眼，卻讓你感到陣陣寒意。
    ->street
+[道歉]
    “抱歉抱歉，剛剛分神了。”你朝他道歉。
    他擺了擺手表示沒事，隨即他又繼續趕路。
    “他手上的紋身怎麼有些熟悉......。”
    ->street

===event11===
~ Times = Times + 1
你發現了一個令人注意的攤位。攤位上擺滿了各種神秘的物品和魔法用品。這個攤位前站著一位年長的小販，他的眼角有著皺紋，但他的眼睛充滿了熱情和活力。他穿著一件色彩繽紛的長袍，上面飾著奇特的符號和紋飾，讓人聯想到古老的巫術師。他的手上佩戴著各種戒指。#portrait:Event11_Vendor/represent
你走近他的攤位，他用親切的語氣說："歡迎歡迎，看你的打扮是外地來的吧，那我更要向你好好介紹我們家的商品了，無論你是在尋找實用的護具，能儲存魔法的寶石，還是增強體質的藥水，我這裡都有！你有什麼需求嗎？"
他用宏亮有精神的聲音向你推銷，仿佛每樣物品都是一個無法錯過的寶藏。
->event11_view

===event11_view===
*[珠寶]
    他舉起一個裝飾華麗的珠寶，開始說道："這些珠寶是從遙遠的寶石礦山中開採而來，那裡的寶石充滿了魔法能量。每顆寶石都是獨一無二的，擁有獨特的魔法屬性。它們可以用於製作強大的魔法藥劑或魔法物品，並在魔法儀式中發揮作用。這些寶石是來自我們這個奇幻世界最偏遠地區的珍寶，它們的來源充滿了神秘和奇幻。"#portrait:Event11_Vendor/germ
    ->event11_view
*[藥水]
    他指向一旁的藥水：”這邊的藥水也是我們的熱銷品，別看這一管沒有多少，卻是能明顯的加強你的身體素質的!你看這邊，我們的商品都有經過公會的認證，效果絕對沒問題!”#portrait:Event11_Vendor/potion
    ->event11_view
*[護腕]
    "這個魔法護腕是由一位卓越的巫師製作的，它具有保護和強化的魔法能力。它可以護住你免受邪惡力量的侵害，同時賦予你額外的力量和能力，使你在冒險中更加強大。它的來源也非常特殊，來自於一個已經消逝的古老文明，它們的巫師擁有強大的魔法傳承。"#portrait:Event11_Vendor/wristband
    ->event11_view
+[購買]
->event11_buy

===event11_buy===
(選擇購買哪個)
    *[寶石$30]#portrait:Event11_Vendor/germ
        {money < 30:
        你翻了翻口袋，發現錢不夠。
        ->event11_buy
        -else:
        ++[殺價(-$5)(難度13,魅力)]
            ~temp res = DiceResult(13, "charisma")
            你順著老闆的話，“老闆你看，我是外地來的，而且又是第一次光臨你們店，能不能給點折扣啊！”#rolling:2
            {res:
                “當然沒問題!"老闆大氣的擺了擺手，”別說我對你不好，算你便宜點吧吧！”<br>(價格調降為$25)#money: -25
                你成功買到了寶石。
                ~money = money - 25
                ->event11_buy
            -else:
                “去去去，沒錢就別買了。”老闆不屑的撇了撇眼，”別在這裡擋路，我還要做生意呢。”
                ->street
                }
        ++[原價購買]
            你成功買到了寶石。
            ->event11_buy
        }
    *[藥水$30]#portrait:Event11_Vendor/potion
        {money < 30:
        你翻了翻口袋，發現錢不夠。
        ->event11_buy
        -else:
        ++[殺價(-$5)(難度16,魅力)]
            ~temp res2 = DiceResult(16, "charisma")
            你順著老闆的話，“老闆你看，我是外地來的，而且又是第一次光臨你們店，能不能給點折扣啊！”#rolling:2
            {res2:    
                “當然沒問題!"老闆大氣的擺了擺手，”別說我對你不好，算你便宜些吧！”<br>(價格調降為$25)#money: -25
                你獲得了藥水，力量增加了。
                ~money = money - 25
                ->event11_buy
            -else:                
                “去去去，沒錢就別買了。”老闆不屑的撇了撇眼，”別在這裡擋路，我還要做生意呢。”
                ->street
                }
        ++[原價購買]
            你獲得了藥水，力量增加了。
            ->event11_buy
        }
            
        
    *[護腕$40]#portrait:Event11_Vendor/wristband
        {money < 40:
        你翻了翻口袋，發現錢不夠。
        -else:
        ++[殺價(-$10)(難度15,魅力)]
            ~temp res3 = DiceResult(15, "charisma")
            你順著老闆的話，“老闆你看，我是外地來的，而且又是第一次光臨你們店，能不能給點折扣啊！”#rolling:2
            {res3:    
                “當然沒問題!"老闆大氣的擺了擺手，”別說我對你不好，算你便宜些吧！”<br>(價格調降為$30)#money: -30
                你獲得了護腕，力量增加了。
                ~money = money - 30
                ->event11_buy
            -else:                
                “去去去，沒錢就別買了。”老闆不屑的撇了撇眼，”別在這裡擋路，我還要做生意呢。”
                ->street
                }
        ++[原價購買]
        你獲得了護腕，力量增加了。
        ->event11_buy
        }
    *[離開]
    ->street

===event12===
~ Times = Times + 1
你遇到了一個龍人珠寶商，他身著華麗的紫袍，頭上戴著一頂金色的頭飾。他看到你頸上的紅寶石項鍊時，他的目光閃爍著貪婪。彷彿他已經決定一定要擁有它。#portrait:Event12_DragonJeweler/side_view
他走近你，微笑著對我說："你好這位貴客。那串紅寶石項鍊看起來相當珍貴。我是一名珠寶商，並且對寶石和珠寶有相當的研究。我不禁好奇，你是否考慮將它出售？我願意以相當慷慨的價格購買它。"
他微笑著說："我理解你對這串項鍊的情感價值，但我可以為你提供一筆極為慷慨的報價，足以讓你獲得一筆巨額財富。十萬金幣，如何?這價格可以買下郊區的一棟房子了!”
(你感到猶豫)
+[同意]
    猶豫再三，你無法抗拒鉅款誘惑。#portrait:Event12_DragonJeweler/money_deal
    “好，成交。”
    在龍人珠寶商誘人的提議下，你最終還是答應了出售那串紅寶石項鍊。他的慷慨報價和誘人的條件使我相信這筆交易將為我帶來財富和機會。
    謹慎地取下項鍊，將它交給了龍人珠寶商。他滿意地接過項鍊，環顧四周，似乎對這筆交易感到滿意。<br>龍人珠寶商表示感謝，說："這位貴客，你做出了明智的選擇。比起只能觀賞的寶石，還是金幣更適合你現在的處境。來吧，這裡是你的十萬金幣，去換一套新衣服吧。"#money:100000
    你興高采烈的離開。<br>(好似聽到了一聲嘆息，你已死亡。)
    ->END
+[拒絕]
    “不了，我想繼續保留著它。”#portrait:Event12_DragonJeweler/head_lower
    商人眼神有些失望，他連忙又說”那十五萬呢?不，二十萬，很少看見這麼純淨的紅寶石!”
    你受不了他的糾纏，離開現場。
    ->street

===Node2===
突然，一隊士兵騎著華麗的戰馬出現在街道上，他們穿著華麗的鎧甲，手舉繡有金色帝國標誌的大旗，彷彿在宣示著他們的權威。隨著士兵的到來，人群中掌聲和歡呼聲此起彼落，顯示出這是國王的巡街。#portrait:Node2_KingDemonstration/army_come #bgm:stop #music:Demonstration
隨著國王的馬車出現，整個城市沸騰，人們大喊他的名。”艾德里克! 艾德里克!”
+[詢問一旁的路人]
    ”他是誰啊，怎麼這麼大陣仗?” 他驚訝道："你不認識?他是我們的國王：艾德里克。也是聖光的代表者。他的統治維護了這片土地的和平與繁榮。"
你注視著國王，感受到他身上的威嚴和力量。單是他的存在給予了這個城市和國家一份特殊的希望和安全感。
國王艾德里克坐在華麗的馬車中，身穿一套藍色絲緞長袍，戴著華麗的皇冠。他的頭髮灰白，鬍子修剪整齊，面容中透露出智慧和威嚴。他的眼睛深邃，瞳孔如星辰般閃爍，他的臉上總是帶著一絲溫暖的微笑。艾德里克的存在散發著君王的風采，並讓人感到他是這個國家的堅強領袖。#portrait:Node2_KingDemonstration/king
坐在國王旁邊的是他的女兒，公主艾莉娜。她有著金髮和湛藍的眼睛，肌膚白皙，她穿著一襲華麗的禮服，上面鑲嵌著寶石和珠寶。她的美麗和優雅令人印象深刻，而她的微笑充滿溫暖和親切。艾莉娜公主是國王的驕傲，也是這個國家的未來。#portrait:Node2_KingDemonstration/princess
當國王和公主緩緩經過，人們紛紛向他們致意。他們的存在為整個城市帶來了希望和喜悅。
據說，公主曾患上了一種嚴重的疾病，她的生命垂危。醫師無能為力，魔法師也束手無策，整個國家陷入了深深的擔憂和絕望之中。
國王艾德里克不斷痛苦地祈禱，祈求神能拯救他的女兒，不計代價。他在神壇前跪拜了無數個日夜，一心一意地為公主求情。
在第十天的深夜，一道神秘的光芒突然照亮了公主的病房，這光芒似乎有著神奇的醫治力量。公主的病情突然有了好轉，她的臉色變得紅潤，體力逐漸恢復，病症漸漸消失。
這一奇蹟引起了人們的驚嘆，他們相信國王的真誠祈禱感動了神明，使公主獲得了重生。這個故事傳遍了整個國家，眾人紛紛讚頌著這偉大的事蹟。
當我看著國王和公主，心中充滿了欽佩和尊敬，那串紅寶石的項鍊突然輕微地震動，這引起了我的疑惑。我感到這個寶石似乎對他們有某種特殊的共鳴，或者有著隱藏的信息。#portrait:Node2_KingDemonstration/necklace
國王艾德里克坐在華麗的馬車中，臉上掛著微笑，突然轉頭朝我看了一眼，若有所思，似乎他對我身上的紅寶石項鍊產生了興趣。
國王的目光在我身上停留了片刻，然後他緩緩地移開了視線，繼續觀望前方。這個瞬間讓我感到一陣莫名的壓力，彷彿國王在某種方式的默認中尋找到了我身上的秘密。#portrait:Node2_KingDemonstration/king
我繼續緊握著項鍊，心中充滿了疑惑和好奇。
隨著國王和公主的隊伍繼續前進，漸行漸遠，我留在原地，看著他們消失在遠方的街道上。我的心中充滿了疑問和好奇，這串紅寶石項鍊似乎是我的指引，但我不知道應該前往何處。#portrait:Node2_KingDemonstration/army_leave #music:stop
->Node3

===Node3===
”感覺到好像有個視線一直看我。”你多次回頭，卻都沒有找到視線的來源。<br>觀看國王巡街的人群還未散去，你只能跟隨著人流移動。#portrait:Node3_ToForest/crowd #music:Stalker
突然，你感覺到有人抓住你的手，定睛一看，是一個披著長斗篷的少年。”自然點，跟著我，我能幫你甩掉跟蹤的人。”
“你是……?”你一臉疑惑。<br>“你被國王盯上了，現在他派人跟蹤你。不想被抓住的話就跟著我走。”
跟著他的步伐，你們離開了人流，到了一條小巷。
他脫下連帽，”這一屆的繼承人也真是的，連被跟蹤了都不知道。”他抱怨道，然後看著我。<br>“為什麼這一屆的繼承人會出現在這裡？”他語氣有些急促，且帶著些許責備。#portrait:Node3_ToForest/helper
我向他說明我失去記憶的事情。”嗯......這事情有些奇怪。”他沉思了一會兒。<br>“總之，我們先離開王城吧，這裡不安全。跟我來，我帶你離開這裡。”
(你們離開王城)#music:stop
#changefile:Forest  
->END

===street===
{Times:
-0:
->random5
-1: 
在街上隨意的走著。#portrait:Street_View/Street_1
->random2
-2: 在街上隨意的走著。#portrait:Street_View/Street_2
->random3
-3:在街上隨意的走著。#portrait:Street_View/Street_3
->random4
-else: ->Node2

}

















