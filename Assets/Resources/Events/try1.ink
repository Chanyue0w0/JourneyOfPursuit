INCLUDE globals.ink


//big random event*4
~ ClearEvent()
~ PushEvent(->random1)
~ PushEvent(->random2)
~ PushEvent(->random3)
~ PushEvent(->random4)
~ PushEvent(->random5)
~ PushEvent(->random6)
~ PushEvent(->random7)
~ PushEvent(->random8)
~ PushEvent(->random9)
~ PushEvent(->random10)
~ temp event1 = GetEvent()
~ temp event2 = GetEvent()
~ temp event3 = GetEvent()
~ temp event4 = GetEvent()

//necklace's random events
~ClearEvent()
~ PushEvent(->necklace_wizard)
~ PushEvent(->necklace_oldman)
~ temp necklace_random = GetEvent()

 
當我醒來時，發現自己躺在一個狹窄陰暗的小巷弄裡。<br>”這裡是……?”
我感到一陣混亂。緩慢起身，晃了晃腦袋，試圖理清現在的情況。

+ [環顧周圍]
    -> Begin

=== Begin === //Node1
這個地方對我來說是完全陌生的，如同迷宮般的小巷向四周延伸，高聳的牆壁阻擋了大部分的日光，牆壁的縫隙間充滿了苔蘚，能感受到這裡的溼氣頗重。遠處似乎有個市集，依稀能聽到模糊的喧鬧聲。<br>

我試著回想有關自己的一切，但記憶卻一片模糊。我不知道我是怎麼到達這個小巷的，也不記得自己的名字或背景。茫然如巨獸般將我吞噬。
+ [check self]

摸了摸自身，在褲子的口袋中發現幾枚陳舊的銅幣。”至少我待會能填飽肚子。”<br>更令我感到驚奇的是，從上衣的口袋中，我找到了一串項鍊！上面鑲嵌著一顆巨大的紅寶石。這個紅寶石散發著深紅色的光芒，閃爍著神秘的魅力。我不禁猜想這個寶石的價值和來歷。<br>”為何他會出現在我身上?” 
->necklace

=== necklace===
緊抓著這條項鍊，我感到一種奇怪的親切感，在這陌生的環境中給了我一絲親切感。似乎這項鍊與我的過去有某種聯繫。<br>”要把它放哪呢？戴起來，還是放進口袋中？”我想著。
    
+ [戴在脖子上]
    一番思考後，我決定將項鍊繫在脖子上，這樣就可以隨時查看它，或者如果有人認出項鍊，或許從他那兒聽到些過去的線索。
    ->necklace_random

+ [放進口袋]
    我決定將手中的項鍊輕輕放進口袋中，這樣可以隨時取出來查看，同時也不必讓項鍊引起他人的注意。緩了一陣子，儘管仍然對自己失去記憶感到困惑，但心情總算稍稍平靜了些。
    ->necklace_thief
===necklace_wizard===
沿著巷子走了一段時間，終於離開了巷子，即便到了街上，對這世界的陌生感卻沒有絲毫的減少。<br>突然，一個年邁的法師出現在他面前。他有著長長的白鬍子和深刻的眼神，手裡抓著一隻木製長杖，他眼神銳利而好奇地盯著主角的項鍊，他似乎……認識這條項鍊?<br>

雖然是初次見面，但我仍決定向他搭話，也許他能告訴我些什麼。我說道：“這條項鍊是我醒來時發現的，我失去了記憶，不知道它的來歷或意義。而你似乎知道它？”<br>

法師緩緩點頭，他的眼睛仍然盯著項鍊，像是在思考。然後，他開口說道：“它十分特別。它是個事件的關鍵，是追尋過去的線索，也是一種命運的象徵。你擁有它，就意味著你將走上一條充滿挑戰和崎嶇的道路。”<br>

聽完法師的話後，我的疑惑沒有減少絲毫，卻更確信這條項鍊的重要性。”好吧，至少確定我不能在肚子餓的時候拿它換一些吃的。”我碎碎念道。
    ->event1
===necklace_oldman===
我繼續沿著陌生的巷子漫步，留意著每一個細節，希望能找到一些線索，解開自己的記憶之謎。經過一把路旁的躺椅時，突然感覺到一雙眼睛正注視著我。<br>轉頭一看，發現一位年邁的老者坐在躺椅上，眼神深邃，充滿智慧。老者的表情安詳，似乎對我這位從未見過的陌生人感到興趣。
+[禮貌詢問]#morality:1
    有些好奇，於是我走到老者面前，微微鞠躬，然後輕聲問道："對不起，先生，我失去了記憶，我不知道我是誰，我是如何來到這裡的。您能幫助我嗎？”<br>老者緩緩地轉動頭，一抹微笑浮現在他的嘴角，但他的回答卻令人困惑，"年輕人，有時候，目光是一扇窗戶，它讓我們看到過去，也讓我們窺見未來。"<br>

我皺起了眉頭，試圖理解老者的話語，但這似乎更增加了謎團。我再次問道，"您說的過去和未來，是什麼意思呢？"<br>老者的目光再次注視遠方，他回答說，"每一個人都有自己的故事，年輕人，有時候，我們的過去和未來在我們的眼神中都能找到答案。"<br>
還想再詢問，老者卻已閉眼睡去。
    ++[離開]
        ->event1
    
+[兇他]#morality:-1
    老者的眼神停在我身上，多看了兩眼，然後繼續保持沉默。<br>
身在陌生的地方本就讓我感到不安，老者謎樣的沉默使我變得更煩躁。我厲聲朝他吼道：「你為什麼一直看著我？有什麼問題嗎？」我的話語充滿了敵意，對此時的我來說，老者的凝視已成為一種侵犯，而自己的情況已經夠複雜了。<br>
老者依然保持沉默，只是微微地笑了笑。他的微笑看似平靜，卻有一種智慧的神秘感。<br>老者的沉默和笑容使我感到更加不安，我也知道這件事是我理虧，於是我悻悻然地轉身離開，希望擺脫這種不悅感，繼續尋找自己的過去。
    ->event1
===necklace_thief===
以為將項鍊放進口袋中可以保持低調。然而，在這個陌生的巷子中，他早已被一個狡猾的小偷盯上了。當主角感到一陣涼風掠過身旁時，他立刻明白發生了什麼。<br>小偷在錯身的一瞬間巧妙地偷走了主角的項鍊，而後加速離去，轉眼間便消失在轉角。我連忙跟了上去，不僅是為了追回項鍊，更是為了保護他唯一的線索。<br>
我跑的氣喘吁吁，不得不說，要在一個全然陌生的地方跟上對方不是件容易的事，不久後，我發現小偷倒在巷子裡，一動也不動，嘴邊掛著一抹詭異的微笑。項鍊則被遺落在一旁。<br>我連忙撿起項鍊，在確認過項鍊並無異狀後，我開始打量起小偷的情況。它的目光空洞，呼吸微弱，他的臉上散發出一種不尋常的神秘光芒。
    +[離開]
        我感到一陣不安，不確定小偷遇到了什麼，匆匆忙忙離開了巷子。
        ->event1
    
    +[幫助他]
        “他的狀態看起來很不妙耶。”我想著。看著小偷昏迷在地上，心生一股憐憫之情。<br>    我開始大聲呼叫，成功引起了一些路人的注意。幾位好心的人趕來幫忙，我向他們說明了緣由後，便拿回了自己的項鍊，離開了巷道。
        -> event1
    

===Node2===
突然，一隊士兵騎著華麗的戰馬出現在街道上，他們穿著華麗的鎧甲，手舉繡有金色帝國標誌的大旗，彷彿在宣示著他們的權威。隨著士兵的到來，人群中掌聲和歡呼聲此起彼落，顯示出這是國王的巡街。<br>隨著國王的馬車出現，整個城市沸騰，人們紛紛向他致意，並希望他的風采能為城市帶來好運。<br>
我好奇的詢問一旁的路人：”他是誰啊，怎麼這麼大陣仗?” 他說："這位國王是艾爾德里亞的統治者，他的名字是艾德里克，聖光的代表者。他的統治維護了這片土地的和平與繁榮。"<br>我看向國王，感受到他身上的威嚴和力量。單是他的存在給予了這個城市和國家一份特殊的希望和安全感。<br>
國王艾德里克坐在華麗的馬車中，身穿一套藍色絲緞長袍，戴著華麗的皇冠。他的頭髮灰白，鬍子修剪整齊，面容中透露出智慧和威嚴。他的眼睛深邃，瞳孔如星辰般閃爍，他的臉上總是帶著一絲溫暖的微笑。艾德里克的存在散發著君王的風采，並讓人感到他是這個國家的堅強領袖。<br>
坐在國王旁邊的是他的女兒，公主艾莉娜。她有著金髮和湛藍的眼睛，肌膚白皙，她穿著一襲華麗的禮服，上面鑲嵌著寶石和珠寶。她的美麗和優雅令人印象深刻，而她的微笑充滿溫暖和親切。艾莉娜公主是國王的驕傲，也是這個國家的未來。<br>
當國王和公主緩緩經過，人們紛紛向他們致意，並祝願他們平安和幸福。國王艾德里克和公主艾莉娜的出現為整個城市帶來了希望和喜悅，他們是這個奇幻世界中的優秀領袖，為人們的生活和未來帶來了光明。<br>
人們在國王和公主的巡街過程中議論紛紛，其中一個令人印象深刻的故事是關於公主艾莉娜的生死經歷。<br>據說一段時間前，公主患上了一種嚴重的疾病，她的生命垂危。醫師無能為力，魔法師也束手無策，整個國家陷入了深深的擔憂和絕望之中。<br>
國王艾德里克不斷痛苦地祈禱，他的祈禱充滿了真誠和悲痛，他祈求神明拯救他的女兒，不計代價。他在神壇前度過了無數個日夜，一心一意地為公主祈禱。<br>一道神秘的光芒突然照亮了公主的病房，這光芒似乎有著神奇的醫治力量。公主的病情突然有了好轉，她的臉色變得紅潤，體力逐漸恢復，病症漸漸消失。<br>
這一奇蹟引起了人們的驚嘆，他們相信國王的真誠祈禱感動了神明，使公主獲得了重生。這個故事傳遍了整個國家，成為一個激勵人心的傳說，強調了國王和公主之間的深厚的親情和他們對國家的奉獻。<br>當人們看著國王和公主經過時，他們對這個故事深感敬佩，相信這個國家的繁榮和幸福是建立在真誠、愛與奉獻之上的。國王和公主的巡街成為了一場感恩和慶祝的盛宴，為國家帶來了歡樂和希望。<br>
當我看著國王和公主，心中充滿了欽佩和尊敬，那串紅寶石的項鍊突然輕微地震動，這引起了我的疑惑。我感到這個寶石似乎對他們有某種特殊的共鳴，或者有著隱藏的信息。<br>
當國王艾德里克坐在華麗的馬車中，臉上掛著微笑，突然轉頭朝我看了一眼，若有所思，仿佛在尋找著某個答案。我感到有一陣深邃的目光掃視過我，似乎他對我身上的紅寶石項鍊產生了興趣。<br>國王的目光在我身上停留了片刻，然後他緩緩地移開了視線，繼續觀望前方。這個瞬間讓我感到一陣莫名的壓力，彷彿國王在某種方式的默認中尋找到了我身上的秘密。<br>
我緊握著項鍊，心中充滿了疑惑和好奇。<br>國王和公主的隊伍繼續前進，漸行漸遠，我留在原地，看著他們消失在遠方的街道上。我的心中充滿了疑問和好奇，這串紅寶石項鍊似乎是我的指引，但我不知道應該前往何處。
->event3

===Node3===
    項鍊突然發熱，並射出一道紅光。<br>“向南。”一道飄渺的聲音響起。<br>    我連忙轉頭張望，人群熙攘，卻沒有看到發出聲音的人。<br>我有些不安。但，似乎沒有更好的選擇。
->END//end game

=== random1 ===
~ Times = Times + 1
“好……好餓。”長期的空腹，我的胃發出了一連串的輕微抗議。而我身上的錢只夠支付最簡單的小食物，而它根本連止飢都辦不到。<br>遠處傳來了一串鈴鐺聲，轉身望去，有一台精美的木製馬車正悠悠前行。馬車上滿載各種新鮮的水果，色彩繽紛，散發出誘人的香氣。我無法控制的停了下來，目不轉睛地注視著馬車。
+[繼續盯著馬車看]
    擦了擦嘴邊的口水，”如果有一個水果不小心掉下來，那將是多麼美妙的巧合。”我默默地想著，即使知道這有多麼不切實際。<br>
正當我幻想著，”叩落。”一聲，馬車壓到路上的小石子，震動了一下，又繼續平穩行駛。我抬起頭，震驚地發現路邊遺落了一顆紅蘋果，應該是從馬車上滾下來的。<br>我衝上了撿起來，大口咬下的瞬間，我彷彿見到了天堂。這個突發的小確幸使我心情好了許多。我不禁閉上眼睛，享受著這令人愉悅的一刻。
-> street

+[將馬車弄出個洞，讓果子掉出來]#morality:-1
    
    果子的香氣令我口水直流，飢腸轆轆的感覺變的更加明顯。為了緩解飢餓感，我決定暗中將馬車搞出一個小洞，讓果子掉落在地上。<br>
    小心翼翼地溜近馬車，找到一個適合的時機，用樹枝和石頭破壞馬車的欄杆，弄出一個缺口，果子很快地從洞口滾了出來，洒滿了街道。我連忙撿了三、五顆果子，躲到附近的角落，偷偷地享受這意外的盛宴。
->street

=== random2 ===
~Times = Times + 1
我走進一間酒吧，逃離一下這個陌生的城市的寂寞和不安。推開酒吧的老舊木門，走進一個充滿熙熙攘攘人群和熱鬧氣氛的地方。<br>酒吧的內部裝潢古老而破舊，卻充滿了特殊的韻味。光線昏暗，木制吧臺上擺滿了各種各樣的瓶子，瓶口泛著金屬光澤。人們坐在高椅子上，有的專注於他們的酒杯，有的在交談和笑聲中度過時光。

+[詢問工作]
    我坐在酒吧吧台上，享受著酒吧的氛圍，但也意識到我需要找到一份工作來維持自己的生計。他轉向酒吧的老闆，一位看似經驗豐富的男子，微笑著詢問是否有機會可以應徵工作。
    ~ temp res = DiceResult(20, "charisma")
    #rolling:2
    {res:
    
    (老闆答應了)<br>老闆放下酒瓶，看著我，然後微笑點頭，說道：「當然，我們這裡偶爾需要一些幫手。你有什麼技能或特長呢？」<br>
        我坦誠地分享了我的技能和經驗，雖然他失去了記憶，但他記得自己以前的工作和技能。老闆聽完後，考慮了一下，然後說：「我們需要一位服務生，可以幫忙端酒、送餐，還有保持酒吧的整潔。你有興趣嗎？」<br>
        我表示有興趣，他知道這份工作可以幫助他融入這個城市，也提供了一個機會認識更多的人。老闆告訴他明天就可以開始工作，然後提供了一些簡單的培訓，讓他熟悉酒吧的運作。
    -else:
        (老闆拒絕你)<br>老闆的表情顯得有些為難，然後搖了搖頭說：「抱歉，我們目前並不需要新的員工。」<br>
        有些失望，但也只能尊重老闆的決定，並不是每個機會都會如願。
    }
    ->street
    
+[免費飲料]
    我走到吧檯，找了個位子坐下。調酒師熟練的調起了酒。”是新面孔耶，今天想來點什麼?”他友好的向我搭話。<br>"唉，我也是一肚子疑惑，”我嘆了口氣，”一醒來，發現自己躺在無人的巷子，失去了所有的記憶，發現身上只有一些銅幣，還有個神祕的項鍊……。”<br>興許是酒吧的氣氛所致，我向他分享起了我的茫然。<br>
    他聽完了我的故事，沉思了一會兒。
    ~ temp res1 = DiceResult(8, "charisma")
    #rolling:2
    
    {res1:
    (成功)<br>調酒師注視著我，點了點頭，說道："我明白你的感受，朋友。有時生活的困難會讓我們感到無助。這杯飲料是送給你的，希望它能為你帶來一些安慰。不要擔心，我們都曾經需要幫助，這個酒吧是一個友善的地方。如果你需要聊天或者更多的幫助，我們都在這裡>"。<br>我接過了那杯飲料，感到一股溫暖和希望，”我並不孤單”，這個酒吧成了他在這個陌生城市尋找自我的地方。
        
    -else:
    (失敗)<br>調酒師卻沒有表現出同情，他皺起了眉頭，看起來有些猶豫。似是不相信我的言語。<br>
        "我為你的經歷感到遺憾，也許你只是昨晚喝的比較多，所以才會在巷子中醒來。"他遞給了我一杯水。"
        ”喝點水，醒醒酒吧。”<br>我接過那杯水，感到有些失落，”果然沒有人會相信我的經歷。”喝完眼前的那杯水，我默默地離開了喧囂的酒吧。
        }
    ->street
+[喝酒聽八卦]
    耳朵不經意地捕捉到了一個關於「許願石」的傳說，正好是一群當地居民在聊天中提到的。他感到這個話題非常引人注目，並開始仔細傾聽。<br> 根據傳說，許願石是一個古老種族的傳世秘寶，據說擁有神奇的力量。這塊石頭被認為能夠實現人們最真誠的願望，但它的位置一直是個謎。有人說，這塊寶石被藏在附近的山區，而有人則相信它在城市的某個角落。許多人已經尋找了許願石，但似乎只有少數幸運者真正找到它，並實現了他們的願望。<br>
    “也許，它能幫到我” 心中默默地想著。
    ->street
    
    
    
    
=== random3 ===
~Times = Times + 1
    在街上漫步時，一聲微弱的貓叫聲傳進了我的耳中。抬頭朝著聲音的來源看去，有一隻貓咪蹲坐在一棵樹上，不停地喵喵叫，看起來是隻不小心爬了太高，卻下不來的小貓。
+[幫助他]#morality:1
    彷彿刻進靈魂裡的反射動作，我立刻靠近樹下，試圖協助貓咪脫困。可是貓咪所處的樹枝太高，我無法搆到牠。我四處尋找一些方式來幫助貓咪。<br>
    經過一番詢問，我向附近居民借了一條長梯，它足以讓我安全的救下貓咪。我小心翼翼地爬上梯子，伸出手，緩緩接近貓咪。牠一開始似是有些害怕，見到我伸出手又往後退了幾步。”別怕，我來救你下去。”我不斷地安撫牠，牠逐漸冷靜下來。<br>最終，成功地把貓咪安全地救下來，並放在地上。牠看了我一眼，然後輕快地跑開了，消失在街角。
    ->street
    
+[無視]#morality:-1
    我想了想，雖然有些擔心這隻小貓，但當務之急應該是先釐清我現在的狀況。於是我決定不干涉這個情況，直接離開。<br>我繼續探索四周，希望能找到些關於自己的線索。
    ->street
    
    
    
    
=== random4 ===
~Times = Times + 1
當我漫步在這個奇幻世界的街道上，目光不斷游移，發現了一個令人注意的攤位。攤位上擺滿了各種神秘的物品和魔法用品，閃閃發光的珠寶、古老的魔法卷軸和裝飾華麗的魔杖。這個攤位前站著一位年長的小販，他的眼角有著皺紋，但他的眼睛充滿了熱情和活力。他穿著一件色彩繽紛的長袍，上面飾著奇特的符號和紋飾，讓人聯想到古老的巫術師。他的手上佩戴著各種戒指，每個都閃閃發光，似乎都有著自己的故事。<br>
當我走近他的攤位時，他迎接了我，用親切的語氣說："歡迎！我有許多神奇的物品，無論你是在尋找魔法藥劑、法器還是珠寶，我都能幫助你找到。你有什麼需求嗎？"<<br>他的聲音充滿了興奮，仿佛每樣物品都是一個無法錯過的寶藏。
-> random4_view
===random4_view===
#需要可以重複選擇
*[珠寶]
    他舉起一個裝飾華麗的珠寶，開始說道："這些珠寶是從遙遠的寶石礦山中開採而來，那裡的寶石充滿了魔法能量。每顆寶石都是獨一無二的，擁有獨特的魔法屬性。它們可以用於製作強大的魔法藥劑或魔法物品，並在魔法儀式中發揮作用。這些寶石是來自我們這個奇幻世界最偏遠地區的珍寶，它們的來源充滿了神秘和奇幻。"
->random4_view

*[卷軸]
    他指向一個古老的卷軸，繼續說道："這些卷軸包含著過去的魔法知識和儀式的紀錄。它們來自於我們的魔法學院，那裡的巫師們世代相傳這些卷軸，記錄了無數年的魔法研究和實踐。這些卷軸對於學習和掌握魔法非常有價值，它們是我們文化和歷史的一部分，也是對過去巫師智慧的尊重。"
->random4_view
    
*[護腕]
    "這個魔法護腕是由一位卓越的巫師製作的，它具有保護和強化的魔法能力。它可以護住你免受邪惡力量的侵害，同時賦予你額外的力量和能力，使你在冒險中更加強大。它的來源也非常特殊，來自於一個已經消逝的古老文明，它們的巫師擁有強大的魔法傳承。”

->random4_view

+[購買]
->random4_buy
===random4_buy===

(選擇購買哪個)
    *[珠寶]
        (我掏了掏口袋，發現錢不夠。)<br>我謹慎地看向這位熱情的小販，對他的慷慨表示感謝，然後輕聲詢問：“先生，我對這個寶石非常感興趣，但我的銅幣不夠支付它的全額價格。您是否能夠給我一個小小的折扣，以便我能夠購得它？”<br>
        ~temp res = DiceResult(21, "charisma")
        #rolling:2
        {res:
            ok
        -else:
        老闆委婉地說："對不起，我們這裡的價格都是固定的，無法進一步打折。這裡的每一件物品都很特殊。"<br>"但我真的非常渴望擁有它。是否有其他方式可以讓我購得它，或者您可以提供一些附加的物品或服務？"<br>"我理解你對這個魔法護腕的興趣，但它的價格已經是我可以提供的最優惠價格了。我希望你能夠理解，我也有成本和生計要維持。
        }
        ->random4_buy
        
        
    *[卷軸]
        (我掏了掏口袋，發現錢不夠。)<br>我謹慎地看向這位熱情的小販，對他的慷慨表示感謝，然後輕聲詢問：“先生，我對這個卷軸非常感興趣，但我的銅幣不夠支付它的全額價格。您是否能夠給我一個小小的折扣，以便我能夠購得它？”<br>
        ~temp res1 = DiceResult(21, "charisma")
        #rolling:2
        {res1:
            ok
        -else:
        老闆委婉地說："對不起，我們這裡的價格都是固定的，無法進一步打折。這裡的每一件物品都很特殊。"<br>"但我真的非常渴望擁有它。是否有其他方式可以讓我購得它，或者您可以提供一些附加的物品或服務？"<br>"我理解你對這個魔法護腕的興趣，但它的價格已經是我可以提供的最優惠價格了。我希望你能夠理解，我也有成本和生計要維持。
        }
        ->random4_buy
        
    *[護腕]
        (我掏了掏口袋，發現錢不夠。)<br>我謹慎地看向這位熱情的小販，對他的慷慨表示感謝，然後輕聲詢問：“先生，我對這個卷軸非常感興趣，但我的銅幣不夠支付它的全額價格。您是否能夠給我一個小小的折扣，以便我能夠購得它？”<br>
        ~temp res2 = DiceResult(21, "charisma")
        #rolling:2
        {res2:
        小販靜靜地考慮了一會兒，然後微笑著回答：“當然，我理解每個冒險者都有預算考量。我願意為你提供一個小小的折扣，以確保你能夠購得這個魔法護腕。我相信它將在你的冒險中派上用場。請問你認為多少價格對你來說合理？”<br>我與小販商討了一個合理的價格，最終達成了一個共識。這個互動讓我感到欣慰，因為小販不僅滿足了我的需求，還願意與我妥協，這樣我就能夠購得這個令我感興趣的魔法 護腕。
        -else:
        老闆委婉地說："對不起，我們這裡的價格都是固定的，無法進一步打折。這裡的每一件物品都很特殊。"<br>"但我真的非常渴望擁有它。是否有其他方式可以讓我購得它，或者您可以提供一些附加的物品或服務？"<br>"我理解你對這個魔法護腕的興趣，但它的價格已經是我可以提供的最優惠價格了。我希望你能夠理解，我也有成本和生計要維持。
            ->random4_buy
        }
        +[離開]
        ->street
        
        
        
        
=== random5 ===
~Times = Times + 1
在我漫步於這個奇幻世界的街道上時，遇到了一個龍人珠寶商，他身著華麗的紫袍，頭上戴著一頂金色的頭飾。這位龍人珠寶商的眼睛明亮而精明，當他首次看到我頸上的紅寶石項鍊時，他的目光瞬間閃爍著貪婪。他停下來，靜靜地觀察了項鍊的紅寶石，然後才轉向我，微笑著，彷彿他已經決定一定要擁有它。<br>
他走近我，微笑著對我說："你好，陌生人。那串紅寶石項鍊看起來相當珍貴。我是一名珠寶商，並且對寶石和珠寶有相當的研究。我不禁好奇，你是否考慮將它出售？我願意以相當慷慨的價格購買它。"<br>他又說："我理解你對這串項鍊的情感價值，但我可以為你提供一筆極為慷慨的報價，足以讓你獲得一筆巨額財富。此外，如果你有其他需求，無論是物質財富、珍貴的寶石，甚至是情報，像是...你的過去，你現在充滿迷惘對吧。"<br>
我猶豫了。
+[答應]
    在龍人珠寶商誘人的提議下，我最終答應了出售那串紅寶石項鍊。他的慷慨報價和誘人的條件使我相信這筆交易將為我帶來財富和機會。<br>我謹慎地取下項鍊，將它交給了龍人珠寶商。他滿意地接過項鍊，環顧四周，似乎對這筆交易感到滿意。
    龍人珠寶商表示感謝，然後對我說："你做出了明智的選擇，陌生人。這串項鍊將為你帶來巨大的回報。我會遵守我們的協議，提供給你我承諾的一切。如果你需要我任何幫助或資源，都可以隨時向我尋求。祝你好運和繁榮。"<br>
    “等等，那我的過去呢? 你承諾過要告訴我的。”<br>“還能有什麼，不外乎就是某個落魄貴族，被祖傳的魔法項鍊影響了而已，為了安全的獲得這項鍊，我還得讓你親口說出願意轉讓呢，最近的寶石總是加入一堆詛咒，要不然我就直接搶了。”他一邊默念著，一邊快速離開。<br>
    (好似聽到了一聲嘆息，眼前一片黑暗)
    #死亡
    ->END
    
+[拒絕]
    他的話語充滿了誘惑，顯示出他對這串項鍊的渴望。然而，儘管他的報價極具吸引力，我仍然感到這串項鍊有著更多的意義和使命，我不願輕易出售。<br>我謹慎地回應說："你的提議誘人，但這串項鍊對我來說有著特殊的重要性，我相信它有著某種使命。我尚未準備好出售它，但如果我改變主意，我會記住你的慷慨報價。"<br>
    這位龍人珠寶商雖然表現出一絲不滿，但也知道不宜過於強求。他點頭示意，然後繼續前進，留下我思考著這筆誘人的交易。
    ->street
    
    
    
    
    
=== random6 ===
~ Times = Times + 1
看他的打扮像是個巫師，他在路邊鋪了張地毯，幾顆石頭圍成了一個奇怪的圖形，而水晶球被放在中間，他口中唸唸有詞。看起來是個占卜的巫師。”年輕人，你正在迷惘吧?要不要給你一些建議啊?”他突然向我搭話。
+[無視]
    “感覺就是來招搖撞騙的”我想著。於是裝作沒有聽到，快速離開。
    ->street
    
+[占卜]
    “它怎麼知道?"我有些吃驚。”你要如何幫我?<br>“過來坐著”依言走了過去。手正要放到水晶球上時，他一把撥開我的手。<br>“怎麼了嗎?” 我問道。<br>他手指搓了搓，”你以為不用代價的嗎?”<br>翻了個白眼，”我是不是誤上了賊船了”掏出口袋中的金幣，交到了占卜師的手上。<br>
    
    “嘿嘿，這樣才對嘛”，它滿足的砸了砸嘴。”來吧，手放上來。我跟你說啊，這可是歷史悠久的寶物，從我師父的師傅…”<br>“好了別廢話，快開始吧。”我不耐煩的說道。<br>“現在的年輕人啊…”它開始唸起了咒語。<br>一咬牙，它從一旁的袋子裡抓出了個盒子，裡頭躺著顆紅寶石。占卜師將它放進了那一堆石頭中，原先劇烈震盪的水晶球稍微平靜了下來。<br>看著那顆紅寶石，身上的項鍊有了反應。
    
    ~temp res = DiceResult(11, "power")
    {res:
        黑氣從原本剔透的水晶球冒出，震開了我和占卜師的手掌。<br>占卜師滿頭大汗，它怪叫到”你...你到底是誰!”我都使用了這顆寶石了!
        你走吧，唉，今日諸事不順啊。"<br>我一臉莫名其妙的望著他，"明明是你技術不精吧。是說，那顆紅寶石是什麼來頭?你一拿出它，我身上的項鍊突然發燙。"<br>他沉默了幾秒：難怪啊難怪，好吧，今天算我運氣差。年輕人，這顆石頭給你吧。也許未來你會需要的。<br>
        說完話，它收拾了一地的行李，轉身離去。
        
    -else:
        突然間，項鍊發出了一道紅光，射進了水晶球中，原本不穩定的水晶球頓時平靜了下來。水晶球裡映出的是一團紅光，它四周圍繞著數以萬計的生物。<br>"那是…古老種族們，連傳輸中的種族都有。”占卜師突然說道。”你來頭不小啊。”他的臉色蒼白，看來剛剛的突發事件讓她受了些傷。
        +[幫助他]
            “有我能幫上忙的嗎?畢竟是我害你受傷的。”<br>
            他苦笑道：”不用了，你若真的感到過意不去，不如替我祈禱吧。”<br>我有些愧疚，我閉上眼誠心祈禱”希望，他的傷能盡快好起來。”<br>
            #health:-5
            (他的臉色好了許多)<br>“這顆石頭也給你吧，在未來的旅途，你會用到它的。”它將紅寶石遞給了我。<br>
            剛接過它，一道紅光從項鍊中射出，紅寶石不見了，而項鍊中的紅光似乎又更亮了一些。<br>
            他一臉驚奇，"看來，我的選擇沒有錯。"他滿意的點了點頭。<br>說完話，他收拾了一地的行李，轉身離去。
            ->street
        +[直接離開]
            “這...這該不會又是你想敲詐我的詐騙手法吧!我才不會上當呢!”<br>無法理解發生自己身上的事，我驚慌的離開現場。
            ->street
            
            }

=== random7 ===
~ Times = Times + 1
突然一顆皮球從巷子裡被扔了出來，砸到了我的頭上，讓我感到驚訝。<br>我摸著被球擊中的頭，緩緩轉身，發現幾個好奇的小孩探頭出來，他們看起來非常年輕，充滿了童真和好奇。他們探出頭，充滿期待地看著我，示意我把球扔回給他們。
+[拋回去]
    我把球拋向他們，他們接住球後開心地笑了起來，然後轉身回到巷子裡，繼續他們的遊戲。這個突如其來的互動讓我感到這個奇幻世界充滿了生機和友好的氛圍，小孩們的快樂也讓我感到心情愉快。
    ->street
+[踢走]
    當我拾起地上的皮球時，我突然決定玩個小小的惡作劇。取而代之，我將球踢走，把它踢得遠遠的，讓它在街道上滾來滾去。小孩們的眼睛睃得圓圓的，驚訝地看著他們的球在空中翻滾。然後追趕著球，試圖再次抓住它。<br>球在街道上滾來滾去，小孩們開始歡笑和奔跑，忘卻了我。
    ->street
    
    
    
    
    
=== random8 ===
~ Times = Times + 1
當你漫步在王城的街道上，突然經過一間高級的甜點店時，甜點的香氣佔據了整條街道。我停下腳步，透過櫥窗看到店內，發現這個地方是一家華麗的甜點店，裝潢典雅，擺放著各種精緻的點心和甜點。<br>店內的貴族們坐在精美的桌子旁，享受著下午茶時光。他們身穿華麗的服飾，戴著頭飾，舉著精緻的茶杯，輕聲交談，優雅地品味著甜點和茶。店內的燭光和花朵裝飾使氛圍顯得格外浪漫。<br>
店內的甜點櫃展示了各種精緻的點心，如水果塔、巧克力蛋糕、覆盆子夾心餅乾，以及各種口味的茶。甜點師傅們在後廚巧妙地製作這些美食，每一道點心都看起來像藝術品一般。

+[進到店裡]
    你感到一陣口水流下，想要進去品嚐一些甜點。我走進店內，找一個空位，享受一個令人陶醉的下午茶體驗，並感受這個城市的奢華和優雅。<br>當你走進那家高級甜點店，被美味的甜點吸引，坐下來想品嚐一些點心時，貴族們注意到了我的到來。一些貴族的臉上顯示出鄙視和不滿。<br>
    其中一名貴族招來了店員，低聲與他們交談。店員面露尷尬，隨後向我走來，婉轉地表示貴族們對你的到來感到不滿，要求你離開。<br>我有些不滿，但又不想引起更多麻煩。站起身，順從地離開甜點店，希望在其他地方找到一個可以品味美味甜點的地方。->street
    
+[在外頭觀看]
    我站在玻璃外看著貴族們享用，貌似是注意到了我，一些貴族的臉上顯示出鄙視和不滿，開始交頭接耳，其中一名貴族舉手招來了店員，臉色難看的與店員交談。店員姿態低下的連連點頭，隨即開門朝我走來。<br>"先生，請不要擋在這邊。”他說到。揮手將我趕走。
    ->street
    

=== random9 ===
~ Times = Times + 1
陣陣喧嘩聲伴著幾聲驚呼，原來是有個街頭藝人正在進行一場引人注目的魔法表演。他站在一個小舞台上，周圍擺滿了好奇的觀眾。他舉起手中的法杖，開始念咒語，一道炫目的火焰噴射而出，形成了壯觀的火焰圈。<br>
觀眾們歡呼鼓掌，而街頭藝人的表演還在繼續。火焰炸開，變成玫瑰花瓣散落在空中，讓花瓣飄落到觀眾面前，使眾人置身於飛舞的花海中。<br>
接下來，他伸手一抓，一隻活蹦亂跳的小兔子出現在他的手上，將兔子朝天空一拋，再一彈指，兔子變成了鳥兒，在空中盤旋了一圈後，降落在一個觀看表演的孩子頭上。孩子們的眼睛閃閃發亮，雀躍的又叫又跳。<br>
街頭藝人的表演充滿驚奇和魔法元素，他不斷讓觀眾驚喜不斷，他的技巧和魔法能力令人嘆為觀止。他在整個表演中娛樂著觀眾，將這個奇幻世界的魔法之美呈現給每一位在場的人。这個奇妙的瞬間讓你感到這個世界的魔法和奇幻之處。
->street

=== random10 ===
~ Times = Times + 1
漫不經心的低頭走著，一位匆匆趕路的行人撞到了我。他披著深色斗篷，臉被被長長的兜帽所遮蓋，只露出一雙深邃的眼睛。
+[朝他大喊]
    “走路能不能小心點啊!”我朝他喊。<br>他並未停下腳步，只是轉頭看了我一眼，而後繼續往前走。僅僅是這一眼，卻讓我感到陣陣寒意。->street
+[道歉]
    “抱歉抱歉，剛剛分神了。”我朝他道歉。<br>他擺了擺手表示沒事，隨即他又繼續趕路。<br>“他手上的紋身怎麼有些熟悉......。”我想著。
    ->street

===street===
{Times:
- 1: ->event2
- 2: ->event3
- 3: ->event4
- 4: ->END
}





























