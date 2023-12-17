INCLUDE globals.ink

//1209S
//go into the village
~ClearEvent()
~ PushEvent(->girl_on_tree)
~ PushEvent(->hunt_group)
~ PushEvent(->deer)
~ temp toforest = GetEvent()

//village view
~ ClearEvent()
~ PushEvent(->house)
~ PushEvent(->talk)
~ PushEvent(->hurt)
~ PushEvent(->kids)
~ temp village1 = GetEvent()
~ temp village2 = GetEvent()
~ temp village3 = GetEvent()

//lake
~ ClearEvent()
~ PushEvent(->lake_none)
~ PushEvent(->lake_none)
~ PushEvent(->lake_none)
~ PushEvent(->lake_none)
~ PushEvent(->lake_none)
~ PushEvent(->lake_yap)
~ temp lake1 = GetEvent()
~ temp lake2 = GetEvent()
~ temp lake3 = GetEvent()

//statue
~ ClearEvent()
~ PushEvent(->statue_none)
~ PushEvent(->statue_none)
~ PushEvent(->statue_none)
~ PushEvent(->statue_none)
~ PushEvent(->statue_none)
~ PushEvent(->statue_yap)
~ temp statue1 = GetEvent()
~ temp statue2 = GetEvent()
~ temp statue3 = GetEvent()


你們抵達了一處空地，前方是一大片森林。#portrait:ToForest/first #bgm:forest 
“就把你送到這裡吧，”他說。”接下來的旅途，必須由你自己走完。去找精靈的部落吧，那裡需要你。”少年說道。<br>“要怎麼去?”你滿頭問號。
“拿著這個”，不理會你的問題，他又遞給你一個小袋子，逕直說道，”裡面裝的是爆炸石，用力丟出去就會爆炸，給你自保用。”<br>“欸不是……”#portrait:ToForest/bag 
“祝你順利。”留下這句話，隨著幾句咒語響起，他的身影逐漸淡去。
“我根本什麼都不記得，能不能交代清楚再離開啊。”你喃喃抱怨道。
“是說，易爆物都不用有些防護措施的嗎?”你看著手中的小袋子，有些無語。
->toforest
===girl_on_tree===
無目的的在森林裡走動，突然聽到一聲尖叫，聲音裡透漏出濃濃的不安。#portrait:ToForest/first
+[前往一探究竟]
循著聲音，我找到了聲音的來源。<br>一個精靈小女孩被困在了樹上，她所在的的樹枝只剩一半還勉強支撐著他的重量。#portrait:ToForest/girlontree
    女孩不安的抱著樹枝，一動也不敢動。<br>在她身前有個鳥巢，裡面有個娃娃，看起來是鳥兒叼走了她的娃娃，而女孩嘗試取回。
    ++[上樹救她]#morality: 1
    你大喊”你別害怕，我現在就去救你!”<br>在女孩的下方有一支比較粗的樹枝，如果你先爬到那裏，就從那裏能接住女孩。<br>眼見女孩所在的樹枝已經快撐不住了，你加快了動作。
        “霹拉”， 樹枝斷了，慢慢爬的話鐵定來不及。一手抓著樹幹，雙腳一蹬，顧不得會不會受傷，你朝著空中的女孩撲了過去，抓住她，將她護在懷裡。
        碰的一聲，你重摔在地，腦袋暈暈的，用僅存的最後力氣看了看懷裡的女孩” 好險，她沒事......”#portrait:ToForest/fall
        你暈了過去。
        ->bed
    ++[告訴她能怎麼做]#morality: 1
    你發現在女孩的身後有一根比較粗壯的樹枝，你朝她大喊，試圖引起她的注意。"你別緊張，先不要亂動。"
        聽見你的聲音，她轉頭望向你，神色滿是慌張。<br>見她發現你了，你接著說，"對，先穩下來。在你後面有一根比較粗壯的樹枝，你先慢慢退到那邊，我上去接你。"
        語畢，你小心翼翼的攀上樹，並把她帶安全的帶下樹。
        她鼻音濃重的說："謝...謝謝你。剛剛真的好恐怖。"
        "別再有下次啦，這樣很危險耶。"你告誡她。"好啦，你趕緊回家吧。"
        她姍姍的看著你，有些不好意思地說道，"我...我腿軟掉了。"<br>"......"
        她坐在你的肩上，向你指引到村莊的路。
        (你四處走走)#bgm:stop #music:Village #portrait:Village/collapse
        ->entrance
        
+[避開]#morality: -1
對這裡如此不熟悉，還是先照顧好自己，會有其他人聽到他的求救的吧!
    ->deer_dis

===hunt_group===
“嘶嘶嘶。”一陣陣高頻的聲音響徹雲霄。<br>“那是什麼聲音?”我四處張望。#music:Battle #bgm:stop #portrait:ToForest/first
+[上前查看]
沒過多久，你發現了聲音來源。#portrait:ToForest/surround
    一群尖耳的精靈被數十隻巨大蟲子包圍。<br?那些蟲子渾身漆黑，肢體上覆蓋著堅硬的外殼，散發出微微的金屬光澤;他們的爪子呈曲線狀，有且有著毒液在尖端滴下;頭部呈現怪異的形狀，被拉的極度長，且表面布滿了複眼。
    精靈們被蟲群包圍，健壯的戰士在最外圍，手持長槍和蟲子們對峙，一名手持長杖的年邁精靈站在正中心，似是在維持著守護他們的防護罩;但蟲群不斷的敲擊防護罩，防護罩已然開始搖晃。
    巨大蟲子還在不斷趕來。
    ++[幫忙(難度23,敏捷)] 
    ~temp res = DiceResult(23, "agility")
    “這是什麼狀況......。”你被這情景嚇到了。<br>一名精靈戰士和你對到眼。他有些驚訝，但隨即示意你趕緊離開這危險的地方。
    “難道，我什麼都幫不了嗎?”你自問道。<br>你想到了方才少年給你的爆炸石。<br>“如果我用這些爆炸石引開那些蟲子的注意，他們就能趁機逃離包圍圈了吧。”
        不理會精靈戰士的警告，你小心翼翼的移動到較靠近他們的地方，準備幫助他們。#rolling:0
        {res:
            你將爆炸石丟向為首的那隻巨大蟲子的關節，突如其來的爆炸成功炸斷他的腳，使他失去平衡，蟲群開始紛亂。<br>防護罩的壓力減少了些。
            “快點！趁現在！”你一邊丟出剩下的石頭，一邊朝著那些精靈大喊。#portrait:ToForest/smallboom
            眼見蟲群已亂，精靈們也開始反攻。你繼續亂丟爆炸石。<br>一邊丟，你一邊慶幸：”還好剛剛沒有不小心摔到他。這威力連有硬殼的蟲子都擋不住，何況是我。”
            直到最後一隻蟲子退去，你緊繃的神經才放鬆下來。你直接坐倒在地，腦袋開始暈眩。”怎麼這麼暈啊。”你想著。
            低頭一看，原來方才大腿被劃傷了，大量失血，方才精神緊繃時未意識到。
            “果然，還是有些衝動了。”你喃喃自語，隨後失去意識。#portrait:ToForest/black
            ->bed//O
        -else:    
            你將爆炸石丟向為首的那隻巨大蟲子。”咚。”爆炸石敲到蟲子的硬殼，輕輕彈開。
            “呃...…，這是啞彈嗎?”你無語的看了那顆未爆炸的石頭，在心中咒罵了那個少年無數次。
            這點小插曲引起了一部份蟲子的注意，有幾隻外圍的蟲子朝你靠過來。
            "完蛋了。"你不知所措的退了幾步，隨後一咬牙，把手中剩下的爆炸石丟了出去，隨後轉身就跑。
            “碰！”出乎你意料的，那一包爆炸石炸了開來，直接將位於爆炸中心的蟲子們炸翻。你目瞪口呆的望著這一幕。#portrait:ToForest/bigboom
            “連爆炸都是隨機的嗎?”你默默吐槽。<br>“快來。”一抹身影穿過爆炸的煙霧，將我拉過去。#portrait:ToForest/fog
            隨即一道光束升起，周圍景色變得模糊。
            ->bed
          }  
    ++[靜悄悄離開]
    “這是什麼狀況......。”你被這情景嚇到了。
        趁著那些蟲子未注意到你，你小心翼翼的轉身離開。
        ->deer_dis
+[自保]
對這裡如此不熟悉，還是先照顧好自己，會有其他人聽到他的求救的吧!
    ->deer_dis
    

===deer===
漫無目的的在森林中漫步。”到底要怎麼找到精靈村啊。”你無助的吶喊道。#bgm:stop #music:Deer #portrait:ToForest/first
突然，一隻神聖而威嚴的神鹿出現在我的視線中。它的身軀高大而優雅，銀白色的毛皮閃耀著微光，宛如星空的倒影。神鹿的角如同水晶一樣透明，散發出柔和的光芒，彷彿是由星辰之力所編織而成。#portrait:ToForest/deer
它步履優雅地穿越樹木之間，身旁的花草彷彿為它讓路，微風輕拂著牠的毛髮。牠是這片樹林的主宰。
似是注意到你的注視，他停下來看著你，目光相遇瞬間，一種溫暖而寧靜的感覺湧上心頭。
“我應該跟著他。”即使沒有言語，你卻理解了他想告訴你的事。
跟隨著她的步伐，一處村落出現在眼前。
(你四處走走)#music:stop #bgm:stop #music:Village #portrait:Village/collapse//O
->entrance

===deer_dis===
漫無目的的在森林中漫步。”到底要怎麼找到精靈村啊。”你吶喊到。#bgm:stop #music:Deer #portrait:ToForest/first
突然，一隻神聖而威嚴的神鹿出現在我的視線中。它的身軀高大而優雅，銀白色的毛皮閃耀著微光，宛如星空的倒影。神鹿的角如同水晶一樣透明，散發出柔和的光芒，彷彿是由星辰之力所編織而成。#portrait:ToForest/deer
它步履優雅地穿越樹木之間，身旁的花草彷彿為它讓路，微風輕拂著牠的毛髮。牠是這片樹林的主宰。
似是注意到你的注視，他停下來看著你，你感受到牠深邃的眼眸中閃現出一絲責備的神色。這種眼神彷彿能夠窺見你的靈魂，讓你感到一股無形的壓力，彷彿你的某些行為或思維受到了神鹿的審視。
他轉過頭，繼續走著。
“我應該跟著他。”即使沒有言語，你卻理解了他想告訴我的事。
跟隨著她的步伐，一處村落出現在眼前
(你四處走走)#music:stop #bgm:stop #music:Village #portrait:Village/collapse
->entrance

===bed===
再次恢復意識，你發現自己正躺在床上，身上的傷口已經被妥善處理過了。#portrait:Village/bedroom #bgm:stop #music:stop #music:Village
環顧周遭的環境，"這裡應該就是精靈村落了吧。"你默默地向著。
你掀開門簾，打算四處走走。
->entrance

//village
===entrance===
//maybe some description
~ cnt_village = cnt_village + 1
{cnt_village:
-1:#music:stop #music:Village #portrait:Village/collapse
    ->village1
-2:
->village2
-3:(你四處走走)
->village3
-4:
一名手持長矛的精靈衛士朝你走來。#portrait:Entrance/guard
他說，"隨我來吧外來者，村長要見你。"<br>你略顯驚訝，但決定跟著他。
-> main
}

===house===
本應是住屋的地方，如今有半數是傾倒的狀態。#portrait:Village/collapse
->entrance

===hurt===
一批又一批的精靈被攙扶進村，或缺手斷足，或失去意識，他們無一是完好的走進村子的大門。#portrait:Entrance/wounded 
精靈們來回奔走，忙於安頓受傷的同族。
“這是在戰爭嗎?”你疑惑的在心中想著。
->entrance

===talk===
“請問……”你嘗試向村里的精靈們搭話。<br>他們有些對你視而不見，有些在聽到你的聲音後快速離開。#portrait:Entrance/disgust 
“這裡貌似不怎麼歡迎我。”你默默想著。
->entrance

===kids===
走著走著，一名精靈小孩跑向我，後頭是他的母親在叫著他。#portrait:Entrance/kid //#bgm:stop #music:Village
“你是來幫我們的英雄嗎?”他跑到你跟前，天真無邪的問道。
“我……”即使再遲鈍，你也意識到這裡的情況並不尋常。
他的母親跑了過來，匆忙將孩子拉走。
->entrance

===main===
到了村長的家，他起身迎接，眼神充滿了悲傷。#portrait:Village/master #music:Lament
“旅人啊，我想你一定很好奇，傳說中強悍自傲的精靈族，為何會變成現在這個樣子。”
"曾經，這裡也是一片森林中的寧靜淨土，我們無憂無慮的在母樹的庇護下生活著。"#portrait:Village/pastpeace
“一天，精靈村莊的寧靜被一種黑暗的預兆打破了。一群蟲子般的怪物降臨到了村莊，我們稱呼它們為「枯萎者」，他們懷著惡意入侵了精靈的神聖聖地，試圖傷害母樹並奪取村莊。#portrait:Village/bugattack
即使我們的勇士各個實力強悍，卻仍抵擋不住他們潮水般的侵入。絕望的呼救聲在森林中迴響，我們卻無能為力。
村民們生活在持續的恐懼之中，永遠不知道枯萎者什麼時候會回來。村民們被入侵的記憶所困擾，惡夢和不眠之夜變得司空見慣。”#portrait:Village/pastcollapsed
“為何，找我呢?”你好奇問道。
“因為你胸口的項鍊，"村長將目光轉向窗外，盯著遠處的母樹，沉默良久。#portrait:Village/windowtree
他繼續說：“母樹曾向我們說過，當森林陷入困難時，只有一個人能夠解開枯萎者的詛咒，拯救我們的母樹。這個人，被稱為『魔法之選』，擁有一塊與母樹同源的石頭，它們能夠互相呼應。這塊石頭被鑲嵌在你的項鍊上。”
你默默地聆聽著，了解到這責任的分量。村長望著你：“我們需要你的幫助，旅人。只有你能夠召喚母樹的本源力量，擊退枯萎者，恢復我們的村莊的和平。這是一個危險的使命，但也是一個神聖的使命。”
“可是，我什麼都不會，失去了過去的記憶，甚至不知道自己究竟是誰……。”你有些無助的說。
“別多想，試著專心傾聽。”村長略有深意的說，”你擁有的力量超乎你的想像，尤其是那串項鍊，連我都看不透它。”
看著胸口的項鍊，你心中默默的想：「怎麼所有事情都和你相關啊...。」
+[答應]
    你感到極度的猶豫和壓力，但最終，還是決定接受這個重要的任務。
    有些人在交頭接耳。<br>“我們就這樣接受外人的幫助嗎?我們身為偉大的精靈族的自尊呢?”<br>“你忘了那個傳說了嗎?”有人反駁道。
    “你想說這個人是傳說中的那個人嗎?他根本不像！"他哼了一聲。
    "傳說中的那個英雄，他的身影高大威猛，肩負著古老的盾牌，背負著傳承的劍刃，閃耀著令人瞠目結舌的光芒。他的盔甲上刻滿了戰役的痕跡，每一道劃痕都是他在無數戰場上奮鬥的見證。而這個人，呆頭呆腦的，又這麼瘦弱，只怕連我的弓都拉不開吧。”他譏笑道。
    “就......就算是事實，也沒必要講出來吧。”你想著。
    “我們相信他一次吧，就算不相信他，也要相信母樹的意志吧。”另一人說。
->bless

===bless===
“感謝你，英勇的旅人，母樹的精神會與你同在。”村長說道。#strength: 5 #agility: 5 #charisma: 5 #portrait:Village/light
綠色光點隨著他的言語浮現，環繞著你。最後沒入項鍊中。
村長神色有些驚訝，隨即露出了然的表情。
->female_elf

===female_elf===
“這已經是第幾批了。”又是一批傷痕累累的隊伍迎面而來。那些都是在前線受重傷的戰士。<br>身邊不時傳來幾聲怒哼，除了對敵人的怒意外，更多的是看見同族被重傷的憤怒。
哀傷的精靈坐在樹梢上，她歌唱著，頌唱出對傷兵們的不捨，還有對前線戰士的祝福。#portrait:Others/femaleelf 
聽到了歌聲，你有些失神。
“印象中，我也曾聽過這般哀傷的歌聲。”
一道聲音在腦中響起：
“沒事的，這不是你的錯”
瞬間，茫然、無助、愧疚、不解、濃濃的哀傷。諸多情緒襲向我。
她，是誰?為何我會感到如此悲傷?
似是響應著你的精神變化，項鍊稍稍變熱了些。
->fight_order

===fight_order===
你繼續跟著隊伍前行。
+[依序前往戰場]
#bgm:stop #music:Battle
->lake
+[直奔母樹]
#bgm:stop #music:Battle
->mother_tree

===lake===
    你抵達湖畔，發現那裡的水面已經變得污濁且有毒，湖邊的樹木也凋零枯萎。枯萎者正從水中湧現，它們的身體散發著陰森的氣息。#portrait:Lake/lake
    “沒想到已經擴散到這裡了”身旁的精靈衛士驚呼道。隨即加入前線。
    你看著精靈們魚貫加入戰局，而你卻只能旁觀。<br>你緊緊握住胸口的項鍊，“幫助我。”
    ->lake_roll
  
===lake_roll===
+[(難度15,力量)]
    ~temp res = DiceResult(15, "strength")
    #rolling:0
        {res:
        從你口中冒出了幾個陌生的字節。
        "akvo kirlante frostiĝanta"
        ->lake_win
        -else:    
        你的手被項鍊震了一下。你更用力的抓住項鍊。
        ->lake_roll
            }
===lake_win===
    湖水翻騰起來，氣勢洶洶的撲向成群的枯萎者，將他們沖到了半空中。而後一股寒意襲捲戰場，湖水結凍了，將枯萎者困在其中。#portrait:Lake/iced
    你的出現顛覆了戰局。
    +[探索]
    ->lake_
    +[前往下一個戰場]
    ->statue
===lake_none===
這裡甚麼都沒有。
+[繼續探索]
    ->lake_
+[前往下個戰場]
    ->statue
===lake_yap===
    一枚徽章掉落在此，上頭的刻紋有些熟悉。<br>“這不是王城的標誌嗎?”你驚訝的想道。#portrait:Others/badge
+[繼續探索]
    ->lake_
+[前往下個戰場]
    ->statue
===lake_===
~ Lake = Lake + 1
{Lake:
-1: 你翻找附近草叢。#portrait:Others/grass1
    ->lake1
-2: 你翻找附近草叢。#portrait:Others/grass2
    ->lake2
-3: 你翻找附近草叢。#portrait:Others/grass3
    ->lake3
-else: 精靈戰士催促著你前往下個戰場。
    +[前往下個戰場]
    ->statue
}

===statue===
你們抵達了擺有精靈雕像的空地。#portrait:Statue/statue
枯萎者們盤據著一尊精靈雕像，為首的那隻看到你們前來，挑釁似的朝你們噴了幾口毒霧。#portrait:Statue/poisonfog
->statue_roll
===statue_roll
+[(難度15,力量)]
~temp res = DiceResult(15, "strength")
#rolling:0
    {res:
    你緊握著項鍊，傾聽著，並隨之複誦。<br>"vento kolektanta tranĉo"
    ->statue_win
    -else:
    你的手被項鍊震了一下，你再次緊握項鍊。
    ->statue_roll
    }
===statue_win===
    狂風驟起，將毒霧遠遠吹離我們。隨後變換為滾滾風刃，將枯萎者們撕裂，劃開戰場。//#portrait:Statue/wind
    +[四處探索]
    ->statue_
    +[前往下一個戰場]
    ->spiritual_place
===statue_none===
這裡空無一物。
+[繼續探索]
    ->statue_
+[前往下個戰場]
    ->spiritual_place
->statue_
===statue_yap===
    翻開草叢，你發現一個神祕石盤，它半插在土中，表面刻有交錯的紋路。#portrait:Others/plate
    +[收起]
    你收起了它。
        ++[繼續探索]
            ->statue_
        ++[前往下個戰場]
            ->spiritual_place
    +[髒東西，不拿]
    你看了一眼，選擇無視它。
        ->spiritual_place
===statue_===
~ Statue = Statue + 1
{Statue:
-1: 你翻找附近草叢。#portrait:Others/grass1
    ->statue1
-2: 你翻找附近草叢。#portrait:Others/grass2
    ->statue2
-3: 你翻找附近草叢。#portrait:Others/grass3
    ->statue3
-else: 精靈戰士催促著你前往下個戰場。
    +[前往下個戰場]
    ->spiritual_place
}

===spiritual_place===
你們來到了精靈族聖地。<br>然而，綠意不再，應該充滿威嚴的此處已被枯萎者弄得面目全非。#portrait:Others/ancestor
看到祖地被這樣踐踏，一同過來的精靈族戰士難掩心中怒意，大聲吶喊後直奔戰場。
看著眼前的一切，你莫名感到悲傷。<br>“你們甘於被外族如此踐踏嗎?站起來吧，和你們的後輩一起抵抗吧!”握著項鍊，你朝空中吶喊。
->spiritual_roll
===spiritual_roll===
+[(難度15,力量)]
~temp res = DiceResult(15, "strength")
#rolling:0
    {res:
    "Alvokante praulajn spiritojn por helpo"
    ->spiritual_win
    -else:
    “你們不是自詡為高貴種族嗎?你們的自尊呢?隨著生命一同腐爛於泥土中了嗎?”<br>我喊道，”戰鬥吧，如果你們還記得曾經的那份高傲。”
    ->spiritual_roll
    }
===spiritual_win===
一點一點的金光從土地中冒出，沖向了奮勇廝殺的精靈戰士們。他們精神一振，將戰線又往前推進了些。
有了先靈們的幫助，戰士們成功將枯萎者們擊退。
“終於，到最後了。”你知道，即將迎來最後的對戰。
->mother_tree

===mother_tree===
你們終於來到了母樹樹根，這裡是最後的戰場。#portrait:MotherTree/mothertree
盤據此處的枯萎者數量難以估計，即使集合所有的戰士，在面對排山倒海的枯萎者們仍顯無力。<br>大家逐漸疲憊，再也支撐不住戰線了。
    你抬頭望向母樹，即使如此憔悴，但她的核心仍在穩定的跳動著。
    “你可有聽到你的子民們的聲音，精靈族的母親，你何以忍受的了。”<br>緊握著項鍊，你在心中默念著。
    ->tree_rolling1
===tree_rolling1===
+[(難度15,力量)]
~temp res = DiceResult(15, "strength")
#rolling:0
    {res:
    "protekti homojn"
    無數虛幻的枝條從母樹身上竄出，雖有些虛弱，卻堅定的探向每一位精靈。精靈們身上的傷正一點一點的復原，疲憊感也一掃而空。//#portrait:MotherTree/help
    眾精靈面色驚訝的望向母樹，隨後爆出欣喜的吶喊”是母樹!她在保護著我們。”
    原先精靈們挫敗的氛圍一掃而散，取而代之的是滿滿的戰意。
    ->mother_tree2
    -else:
    你再次堅定的抬頭望向母樹。
    ->tree_rolling1
    }
===mother_tree2===
    即使有了母樹的幫助，戰局也只是由劣勢轉為持平而已。
    “你甘於此嗎?”你再次問道。
->tree_rolling2
===tree_rolling2===
+[(難度15,力量)]
~temp res = DiceResult(15, "strength")
#rolling:0
    {res:
    "kolerega kontraŭatako"。
    竭盡母樹的能量，最後的驚天一擊擊敗了大部分的枯萎者。//#portrait:MotherTree/lastattack
    ->ending
    -else:
    你又望向母樹。
    ->tree_rolling2
    }
    
===ending===
枯萎者們撤退了，精靈村莊恢復了和平。#bgm:stop #music:Victory #portrait:MotherTree/cheer 
“母樹雖然傷痕累累，但至少，我們奪回了她。”眾精靈傳唱道。
在不久的將來，它的根將再次深入大地，重現以往的光榮。
他們慶祝的同時，你默默來到母樹身邊。<br>你知道你有能力修復它。
+[修復]
    你站在母樹的樹根旁，專注地將許願之力集中在手中。這股神秘的力量湧現而出，你感到自己正逐漸虛弱，但你仍未停手。你的手指輕觸著母樹的樹根，你開始傳送這份力量到母樹的身體中。//#portrait:MotherTree/heal
    母樹的樹皮開始變得有光澤，她的葉子重新生機勃發，而根部的損傷也逐漸痊癒。你不停地將許願之力注入母樹，犧牲自己的生命力以換取她的康復。
    最後，當你感覺自己幾乎虛脫時，母樹的傷勢得以修復，她重新恢復了生機和力量。你倒在她的樹根旁，感到疲憊不堪，但也充滿了滿足感。你的奉獻和許願之力成功拯救了母樹，為精靈村莊帶來了和平和希望。
->leave_forest
+[裝作沒辦法]
    你站在母樹的樹根旁，感到內心掙扎，但最終，你抽回了手。//#portrait:MotherTree/notheal
    你不願為了初見的事物犧牲，即便曾一起奮戰。你站在母樹的樹根旁，表現出無奈的表情。
->leave_forest
===leave_forest===
方才，你已經告訴了村長你在王城的經歷，包含那個帶你過來的少年。#portrait:Village/master
村長的臉龐顯得沉重，她的眼神充滿了擔憂。她走到我身旁，遙遙指著東方，"也許，你的所有疑問都能從矮人那裡得知。能將具有強大力量的寶石加工成項鍊的，鐵定只有他們。"
"但是，"村長接著說，"旅人啊，前往矮人的城堡勢必會經過沙漠，而那是一條危險的道路。<br>或許，他們能告訴你更多有關項鍊的信息、找回失去的記憶。又或者，你會在那裡喪命。"#portrait:MotherTree/goodbye
"無論是酷熱的陽光或是無情的風沙，任何一項在沙漠裡的事物都能輕易剝奪你的生命。請小心，旅人，我希望你能平安返回，帶著項鍊的真相和你的記憶。”
"對了，"村長突然想起些什麼，"外圍的小動物們發現，有人在森林外圍徘迴，可能是來追著你來的。"他警告我。
"他們，跟到這裡了嗎......"你有些不安。
(離開森林)
#changefile:Desert #music:stop
->END










