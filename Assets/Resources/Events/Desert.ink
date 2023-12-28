INCLUDE globals.ink

//1216
//set random events
~ClearEvent()
~ PushEvent(->temperature1)
~ PushEvent(->temperature2)
~ temp random1 = GetEvent()

~ClearEvent()
~ PushEvent(->brokenremain)
~ PushEvent(->scorpion)
~ temp random2 = GetEvent()

~ClearEvent()
~ PushEvent(->sandstorm1)
~ PushEvent(->sandstorm2)
~ temp random3 = GetEvent()

~ClearEvent()
~ PushEvent(->temple1_entrance)
~ PushEvent(->temple2_entrance)
~ PushEvent(->temple3_entrance)
~ temp random4 = GetEvent()

你來到了森林的邊界，這裡似是被人用畫筆分出一條明確的界線，線內是滿地綠意，線外是炙熱沙地。你深吸了一口氣，踏過了那條分界線。#portrait:Background/background1#bgm:desert
熱浪迎面而來，提醒著你身處沙漠：一個危機四伏的惡地。只能依著手中的羅盤走著。
「聽說，這裡曾不是沙漠。」你耳邊突然響起方才村長的喃喃自語。
(由於炙熱的天氣，每隔一段時間會減少一些血量。)
->desert_path

===died===
你感到力量慢慢從身體流失，意識慢慢淡去。#portrait:EndingPics/LostMan
->END

===temperature1===
「快融化了。」你喃喃自語，「早知道水就省著點喝。」(HP-1)#portrait:Surrounding/sun #health: -1
~health = health - 1
這片烈陽下，你感受到身上的水份仿佛隨時都要蒸發殆盡。嘴唇微乾，但水袋裡早已空蕩蕩，只能聊勝於無的拿來搧風。
你晃了晃水袋，感受到手心的溫熱。裡面早已沒有一滴水，只剩下袋子內凹的形狀，顯示出早前的用水之匱乏。盡管喉嚨渴望著水分，但眼前這空空的水袋卻是你唯一的訴苦對象。
汗水直冒，卻絲毫無法減緩熱意。陽光灼熱的灼人，你感受到每一滴汗珠都是身體在與大地共鳴的象徵。濕漉漉的衣物貼在身上，帶來短暫的涼意，卻也隨即讓你感受到悶熱的不適。
你努力忍受著烈陽的侵襲，頭暈目眩中，對於水的渴望更加強烈。
->desert_path

===temperature2===
「真是火辣的天氣。」你不禁自語，額頭上的汗水早已湧現，蒸騰的熱氣悄悄地融化你的意志。眼前的沙漠一片廣闊，烈陽如同無情的火焰，熾熱而令人窒息。(HP-1)#portrait:Surrounding/sun #health: -1
~health = health - 1
你揮動著手中的水袋，但裡面只剩下一絲熱風，仿佛在輕輕譏笑你的大意。沙漠風吹過，帶著灼熱的砂石，如同沙塵暴中的野獸，撲面而來，讓人感到無處遮蔽的絕望。
身上的衣物猶如烘爐布，貼在皮膚上，每一步都彷彿在火炭上行走納什的地面散發著灼人的熱氣，仿佛腳下是一片沸騰的火爐。這裡的陽光不僅照耀，更像是一把無情的火焰，將一切生命的水分盡情吸食。
在這片曠野中，你感受到了大地的極端酷熱，每一口呼吸都似乎帶有灼熱的味道。沙漠風吹過，帶走了你身上的水分，留下的只有一種焦渴的渴望。這是納什的試煉，而你必須在這片炙熱中找到生存的力量。
->desert_path

===brokenremain===
巨大石塊散落，有些零散，但，似乎能組成一座建築。(HP-1)#portrait:Surrounding/bigstone1 #health: -1
~health = health - 1
「是風沙太大吹毀的嗎?」你疑惑道。
周圍已無人跡，看來並非近期發生的。//查看?
->desert_path

===scorpion===
沙地下傳來低沉的震動聲，無數巨大的蠍子從沙堆中浮現。(HP-1)#portrait:Surrounding/scorpion #health: -1
~health = health - 1
牠們的外骨骼閃著金屬般的光澤，對比著沙漠中的灰沙。
這些巨蠍的鉗子鋒利無比，尾巴上帶著毒刺。牠們的眼睛透露著兇猛和敏銳，宛如沙漠中的戰士般威嚴。在陽光的照射下，巨蠍的外殼閃著金屬光芒，使其看起來更加威嚴可怕。
在這片歇息的時光中，你可以考慮如何趁著牠們沉靜的時候通過，或者尋找其他安全的路線。然而，必須謹慎行動，因為一旦巨蠍們感受到威脅，牠們將迅速恢復戰鬥狀態。
+[潛行通過(難度21,敏捷)]
~temp res = DiceResult(21, "agility")
    #rolling: 0
    {res:
    你無聲無息地經過巨蠍群。
        ->desert_path
    -else:
    你不小心被發現了。他們朝你衝來。
        ++[逃跑(難度13,敏捷)]
        ~temp res2 = DiceResult(13, "agility")
        #rolling: 0
        {res2:
            你成功逃脫。
            ->desert_path
        -else:
            殘酷的沙漠消磨了你的精力，即使奮力奔跑，你仍被螯劃到了背部。#health: -5
            ~health = health - 5
            {health < 1:
            ->died
            -else:
            確認過對牠們來說並非威脅，巨蠍們回到原處繼續休息。
            ->desert_path
            }
        }
    }
    

===sandstorm1===
突然間，天空變得灰沉，沙漠中的空氣彷彿變得厚重。遠處的風暴正在迅速接近，帶著千萬顆細小的沙粒，形成了一場可怕的沙暴。#portrait:Surrounding/sandstorm
風沙呼嘯而至，視線被遮蔽，周圍一片灰白。你迅速用手遮擋著臉，努力防止細小的沙粒進入眼睛。<br>風勢強烈，沙粒在空氣中亂舞，彷彿千萬支小箭一般。
沙暴中，你感受到肆虐的自然力量，沙塵籠罩了整片區域，讓你難以分辨方向。在這一刻，你得盡快尋找掩護之處，避免被風沙侵襲。
你急匆匆地四處張望，希望找到一個可以避風躲沙的地方。
沙暴來勢洶洶，讓整個沙漠都顫抖在風暴的吼聲中。這是一場自然的狂歡，而你必須在這場狂風肆虐的沙漠中找到生存的機會。
->desert_path

===sandstorm2===
突然，天空變得陰霾，沙漠的平靜被瞬間打破。沙塵在風中翻騰，形成一幅混沌而神秘的畫面。<br>風勢迅速增強，帶來了千萬細小的沙粒，如同沙漠的狂妄之舞。#portrait:Surrounding/sandstorm
沙塵中的風暴向你席捲而來，模糊了視野，使得周遭的景物彷彿在一片濃霧中般隱約可見。你感受到風的咆哮聲，彷彿是沙漠中潛伏的巨獸正在怒吼。沙粒擦過臉龐，帶來一陣刺痛感，你緊緊閉上眼睛，試圖保護自己的視力。
在這肆虐的沙暴中，你感到身體受到風沙的輕微割傷，宛如千刀萬箭穿透肌膚。恐慌中，你必須迅速尋找遮風避砂的地方，以免被這場風暴所淹沒。
眼前的沙塵漸漸變得濃密，你急切地尋找著，希望能找到一處能夠避風躲沙的石缝或地形高低差，暫時躲過這場自然的狂襲。<br>風暴帶來的沙塵迫使你做出迅速的抉擇，生存的本能推使你不敢停頓，只求能夠在這肆虐的沙塵中找到一絲安全。
->desert_path


===temple1_entrance===
石門矗立，門板中間布滿了紋路，雖說有些磨損，但大致線條仍是完整的。#bgm:stop#music:Thesun#portrait:Temple/stonedoor1
+[嘗試推開(難度21,力量)]
    你嘗試推開這扇門。
    ~temp res = DiceResult(21, "strength")
    #rolling: 0
    {res:
    門發出轟隆巨響，你進到了遺跡中。
        ->temple1_in
    -else:
    即使用背靠著石門，用全身的力氣推向石門，他依舊紋絲不動。
    「 難道要這樣莫名的死在風沙中嗎?」你心中默念道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q1
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple1_choice
    }
+[靠著]
    「看這石門的大小，鐵定推不動的。」沿途的勞累已然消耗掉你所有的動力。
    「就這樣消逝在風沙中，似乎也不錯。」你消極地想道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q1
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple1_choice

===temple1_choice===
(請依照圖示，選擇你的答案)
*[4322]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple1_choice
}
*[1243]
門發出轟隆巨響，你進到了遺跡中。
->temple1_in
*[0332]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple1_choice
}
*[0323]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple1_choice
}
===temple1_in===
這裡漆黑一片，你小心翼翼地貼著牆行走，雖然看得不是很清楚，但仍能辨認出這是一條單向的通道。#portrait:Temple/hallway
走了一段時間，環境變亮了些，你看清了周圍。
這裡是一個大廳，這裡的屋頂被天花板的裂縫漏下的陽光點亮，散發著微弱的光芒。大廳中的柱子上刻滿了神秘的符號，地面上鋪著古老的石板，隨著你的腳步發出微弱的回音。#portrait:Temple/wall
牆上，一幅幅壁畫展列，述說著曾經的輝煌。
畫面的中心，一顆瑰麗的石頭閃耀著光芒，它是許願石，是由神的眼睛製成的。
神將這顆石頭賦予了被選定的種族—奈瑟族，並交付他們「幫助世人」的使命，同時，為了避免它被不當使用，這個種族的人也被加諸了另一項限制：不能傷害生物
奈瑟族人謹記神託付的使命，展開了他們的冒險，他們遊走於世界的各個角落。
在他們的付出下，世界逐漸變得美好，和平與繁榮在他們的引導下綻放，奈瑟族的傳說也散布到了各個角落。
看著這些壁畫，你感到有些熟悉。似是，你曾見證過這一切。
你發現了另一條通道，你沿著它離開這座遺跡。
->desert_path

===temple2_entrance===
石門矗立，門板中間布滿了紋路，雖說有些磨損，但大致線條仍是完整的。#bgm:stop#music:Thesun#portrait:Temple/stonedoor2
+[嘗試推開(難度21,力量)]
    你嘗試推開這扇門。
    ~temp res = DiceResult(21, "strength")
    #rolling: 0
    {res:
    門發出轟隆巨響，你進到了遺跡中。
        ->temple2_in
    -else:
    即使用背靠著石門，用全身的力氣推向石門，他依舊紋絲不動。
    「 難道要這樣莫名的死在風沙中嗎?」你心中默念道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q2
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple2_choice
    }
+[靠著]
    「看這石門的大小，鐵定推不動的。」沿途的勞累已然消耗掉你所有的動力。
    「就這樣消逝在風沙中，似乎也不錯。」你消極地想道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q2
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple2_choice

===temple2_choice===
(請依照圖示，選擇你的答案)
*[153]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple2_choice
}
*[135]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple2_choice
}
*[315]
門發出轟隆巨響，你進到了遺跡中。
->temple2_in
*[513]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple2_choice
}

===temple2_in===
這裡漆黑一片，你小心翼翼地貼著牆行走，雖然看得不是很清楚，但仍能辨認出這是一條單向的通道。#portrait:Temple/hallway
走了一段時間，環境變亮了些，你看清了周圍。
這裡是一個大廳，這裡的屋頂被天花板的裂縫漏下的陽光點亮，散發著微弱的光芒。大廳中的柱子上刻滿了神秘的符號，地面上鋪著古老的石板，隨著你的腳步發出微弱的回音。#portrait:Temple/wall
牆上，一幅幅壁畫展列，述說著過去的歷史。
大廳壁畫中，場景轉換至一處矮人的工匠坊。在這個神秘的場景中，矮人工匠們專注地將那顆神奇的石頭巧妙地加工，精心地鑲嵌在一條項鍊上。石頭的光芒在他們手中閃耀，彷彿是在回應著工匠們的巧手。
而在另一側的壁畫上，描繪著矮人王和奈瑟族長的畫像。矮人王威嚴而堂皇，他的眼神充滿了智慧和領導力，手中握著一把矮人王的權杖。奈瑟族長的畫像則呈現出一種神聖和崇高的氛圍，他的目光中似乎蘊含了對整個種族的深深關懷。
整個壁畫交織出一幅宏偉的畫卷，描繪了矮人工匠的巧手之下，神奇的石頭變成項鍊，再到矮人王和奈瑟族長的領導下，呈現出一個神聖而繁榮的世界。這些畫像彷彿是歷史的見證者，將那段古老而奇幻的故事展現在觀者眼前。
看著這些壁畫，你感到有些熟悉。似是，你曾見證過這一切。
你發現了另一條通道，你沿著它離開這座遺跡。
->desert_path


===temple3_entrance===
石門矗立，其中一角已然碎裂；門板中間布滿了紋路，雖說有些磨損，但大致線條仍是完整的。#bgm:stop#music:Thesun#portrait:Temple/stonedoor3
+[嘗試推開(難度15,力量)]
    你嘗試推開這扇門。
    ~temp res = DiceResult(15, "strength")
    #rolling: 0
    {res:
    門發出轟隆巨響，你進到了遺跡中。
        ->temple3_in
    -else:
    即使用背靠著石門，用全身的力氣推向石門，他依舊紋絲不動。
    「 難道要這樣莫名的死在風沙中嗎?」你心中默念道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q3
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple3_choice
    }
+[靠著]
    「看這石門的大小，鐵定推不動的。」沿途的勞累已然消耗掉你所有的動力。
    「就這樣消逝在風沙中，似乎也不錯。」你消極地想道。
    你伸手抓起項鍊，經過之前的旅途，不知不覺間，你已將這串項鍊視作珍貴之物。你靠著石門，心中升起放棄的念頭。
    似是感應到項鍊的出現，石門晃了晃。幾束光影從紋路間浮出，投影出一幅圖樣。#portrait:Temple/Q3
    端詳了那幅圖，你苦笑道，「原來，是需要解謎的嗎?」
        ->temple3_choice

===temple3_choice===
(請依照圖示，選擇你的答案)
*[4]
門發出轟隆巨響，你進到了遺跡中。
->temple3_in
*[8]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple3_choice
}
*[16]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple3_choice
}
*[32]
門紋絲不動。#health: -1
~health = health - 1
{health < 1:
->died
-else:
->temple3_choice
}

===temple3_in===
你在黑暗的通道中小心翼翼地前行。#portrait:Temple/hallway
「匡噹。」你撞到了某個靠著牆角的東西，但周圍太黑了，你辨認不出來這是甚麼。
於是你繞過了它，繼續沿著牆壁前行。
又走了一段時間，環境變亮了些，你看清了周圍。
這裡是一個大廳，這裡的屋頂被天花板的裂縫漏下的陽光點亮，散發著微弱的光芒。大廳中的柱子上刻滿了神秘的符號，地面上鋪著古老的石板，隨著你的腳步發出微弱的回音。#portrait:Temple/skeleton1
牆上，本應是展列壁畫處，如今充滿了各種划痕，還有一些爆炸後的灰黑。
蒼白骷顱散布在大廳，即使經過漫長歲月，依然可以感受到當時的痛苦氣氛。
「這裡，到底發生了什麼事。」你疑惑道。
心中莫名刺痛了一下，無來由的。
你發現了另一條通道，你沿著它離開這座遺跡。
->desert_path

===bighole===
即使有羅盤的指引，你依舊迷失了方向。#portrait:Background/background1#bgm:go#music:stop
「往高處爬吧，看能不能辨認出正確的方向。」你一邊想著，一邊走向附近最高的沙丘。
爬到了最高處，你環顧四週，依稀能看到後方遠處的一小片綠意，「哦，看到森林了。」有了參照物，你也順利辨認出矮人城堡的方向。
「等等，這是……?」你驚呼出聲。#portrait:Surrounding/bighole
一個巨大深坑坐落在東邊的不遠處，深不見底，彷彿是通往深淵的入口。
他的規模之大，是人力無法造成的，但他出現的突兀，與其說是自然形成，更像是人為造成的結果。
你回想起沿路走來遇到的事物，越來越覺得這裡不單純。
->desert_bus

===desert_bus
在無垠的沙漠中，一位孤獨的流浪商人出現在你的視線中。他背負著一個古老的行囊，布滿沙塵的長袍在風中拂動。他的面容隱藏在一頂寬大的斗篷下，只露出一雙深邃的眼眸。#portrait:Surrounding/businessman
你走近他時，他轉過頭，微微點頭示意。
「需要補給品嗎?」他聲音有些沙啞的問道。他的臉上刻滿了時光的痕跡，看起來經歷了無數次的風沙洗禮。沙漠的寂靜中，只有他腳步的輕微聲和風沙的呼嘯。
+[購買]
    流浪商人的攤位上擺滿了各種生存於沙漠的必需品。首先，你注意到他的水囊，裝滿了清澈的淡水，這在沙漠中是無價之寶。旁邊擺放著裝滿各式乾糧和乾果的袋子，作為長時間旅行的糧食選擇。
    此外，他還提供各種防風道具，如厚實的頭巾、風沙罩，以及能夠抵禦太陽灼熱的長袍。這些物品簡單而實用，是在沙漠中生存不可或缺的裝備。
    流浪商人靜靜地站在攤位前，等待著你的選擇。他的眼中透露著經驗豐富的眼光，仿佛他能夠理解你在這片廣袤的沙漠中所需的一切。
    ->desert_buy
+[打探消息]
你決定向商人打探消息。
    ->desert_news

===business_choice===
+[購買]
你決定向商人購買補給。#portrait:Surrounding/businessman
    ->desert_buy
+[打探消息]
你決定向商人打探消息。#portrait:Surrounding/businessman
    ->desert_news
    
===desert_buy===
+[藥水(可以增加各項基礎數值)]#portrait:Surrounding/businessman
    ++[力量藥水(+2)$20]#portrait:Surrounding/potion_strength
        {money < 20:
        「你的錢不夠了，要換一件商品嗎?」商人問道。
            ->desert_buy
        -else:
        ~money = money - 20
        你感覺力量增加了。#strength:2 #money:-20
            ->business_choice
        }
    ++[敏捷藥水(+2)$20]#portrait:Surrounding/potion_agility
        {money < 20:
        「你的錢不夠了，要換一件商品嗎?」商人問道。
            ->desert_buy
        -else:
        ~money = money - 20
        你感覺自己速度變快了。#agility:2 #money:-20
            ->business_choice
        }
    ++[魅力藥水(+2)$20]#portrait:Surrounding/potion_charisma
        {money < 20:
        「你的錢不夠了，要換一件商品嗎?」商人問道。
            ->desert_buy
        -else:
        ~money = money - 20
        好像變得更好看了(?)<br>(別想了，這只是錯覺。)#charisma:2 #money:-20
        ->business_choice
        }
+[食物(恢復血量)$10]#portrait:Surrounding/food
    {money < 10:
    「你的錢不夠了，要換一件商品嗎?」商人問道。
        ->desert_buy
    -else:
        ~money = money - 10
    你感覺體力恢復了一些。#health:10 #money:-10
    ~health = health + 10
    ->business_choice
    }
+[查看其他選項]
你詢問商人有沒有其他選擇。
    ->business_choice
+[離開]
(你已經做完了補給。)
    ->leave

===desert_news===
+[打聽過去]
    「過去哦……」商人抬頭望天若有所思，隨後嘆了口氣。
    「這裡，曾是最為繁榮、最為多樣的和平之地。」他的眼神看向遠方，似是穿透了時空。#portrait:Surrounging/peace
    「雖然沒有名義上的王，但大家都跟隨著奈瑟族的引導生活。種族的差異不再是紛亂的藉口。」商人自豪的說道。
    「但是，和平並不長久。」說道這，他的神色黯淡了些許，「一天，奈瑟族被不知名的勢力攻擊了，過往的平衡在一瞬間消失。」
    「戰亂四起，和平之地變為最殘酷的戰場，廝殺聲不絕於耳。」他抖了一下。#portrait:Surrounging/war
    「後來是多明尼特介入，在戰場的中心投下一顆毀滅武器，以絕對暴力之姿平定紛亂。」
    「雖說和平了，但環境也毀了，再也回不到過去的美好，奈瑟族的蹤跡也成了謎。」他又重重的嘆了口氣。
    「不提了不提了。」他朝我擺了擺手，結束這個話題。
    ->desert_news
+[詢問矮人領地]
    流浪商人聽到你對矮人領地的興趣，他好奇地問道：「你想去矮人領地嗎？」
    你點頭肯定，回答說：「對，我想去那裡探詢一些事情。」
    商人眼中閃爍著興奮的光芒，他笑著說：「那你可太幸運了。這個時候前往，恰好可以趕上那索珈王權日。這是矮人王上任一周年的慶祝活動，聽說會宣布一項大發明，矮人的工藝讓人期待不已。」
    ->desert_news
+[查看其他選項]
    ->business_choice
+[離開]
    ->leave
    
===leave===
「朝這個方向走，大概再半天就能看到矮人的城堡了。」商人指向北方。#portrait:Background/background2
向他到過謝，你繼續踏上旅程。
(你離開了納什)#bgm:stop#music:stop
#changefile:Castle
->END

===desert_path===
{Desert:
-0:
~ Desert = Desert + 1
(HP-2)#portrait:background/background1#health:-2
~health = health - 2
{health < 1:
->died
-else:
->random2
}
-1: 
~ Desert = Desert + 1
#portrait:background/background2#health:-2
~health = health - 2
{health < 1:
->died
-else:
->random3
}
-2: 
~ Desert = Desert + 1
(HP-2)#health:-2
~health = health - 2
{health < 1:
->died
-else:
->random4
}
-else:
->bighole

}

