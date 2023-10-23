那邊那位年少有為的! #speaker:精靈長老 #portrait:Elf1/faceImage
->main

=== main ===
你今天過得如何阿?
+ [開心]
    我也為你感到開心!!
    
+ [難過]
    真假，==

- 不要相信他，他才不是精靈長老! #speaker:精靈少女 #portrait:Elf2/faceImage

那麼，你的選擇是相信那位少女還是我呢? #speaker:精靈長老 #portrait:Elf1/faceImage 
+ [相信少女，與長老戰鬥]
    你用許願符的神力勉強擊傷眼前的精靈長老，但你也因此受了重傷 #speaker: #health:-60 #morality: -1
    -> END
+ [相信少女，隨她前去部落]
    -> sub1
+ [相信長老，隨他前去部落]
    -> sub1
+ [保持沉默]
    (長老皺眉)我先離開了，你想清楚了再來找我
    -> sub2
    
=== sub1 ===
你隨之前往森林深處，不料突然出現一群女巫 #speaker: #background:witches
    -> END
    
=== sub2 ===
你一個人餓死在了森林中央 #speaker: #health:-100
    -> DONE