// (->knot) 就是path
EXTERNAL PushEvent(a)
EXTERNAL GetEvent()
EXTERNAL ClearEvent()
// (難度, strength/agility/charisma)
EXTERNAL DiceResult(a,b)

我坐在酒吧吧台上，享受著酒吧的氛圍，但也意識到我需要找到一份工作來維持自己的生計。他轉向酒吧的老闆，一位看似經驗豐富的男子，微笑著詢問是否有機會可以應徵工作。#portrait:Event2(Bar)/boss
~ temp res = DiceResult(20, "charisma")
#rolling:2

~ ClearEvent()
~ PushEvent(->main1)
~ PushEvent(->main2)
~ PushEvent(->main3)
~ temp event = GetEvent()
-> event




=== main1 ===
You encounter an elder elf #portrait:Elf1/faceImage #speaker:Narrator
    +[fight]
        ~ temp res = DiceResult(20, "strength")
        #rolling:2
        {res: 
            Victorious, you strip them of their clothes in triumph #strength:1
        -else: 
            You suffer defeat and endure injuries. #health:-10
        }
        
    +[ask]
        Answer your question and walk away #speaker:elder elf #morality:1
- -> street

=== main2 ===
You encounter an elven maiden. #portrait:Elf2/faceImage #speaker:Narrator
    +[fight]
        ~ temp res = DiceResult(20, "strength")
        #rolling:2
        {res: 
            Victorious, you strip them of their clothes in triumph #strength:1
        -else: 
            You suffer defeat and endure injuries. #health:-10
        }
        
    +[ask]
        Answer your question and walk away #speaker:elven maiden #morality:1
- -> street

=== main3 ===
You encounter a human. #portrait:Human1/faceImage #speaker:Narrator
    +[fight]
        ~ temp res = DiceResult(20, "strength")
        #rolling:2
        {res: 
            Victorious, you strip them of their clothes in triumph #strength:1
        -else: 
            You suffer defeat and endure injuries. #health:-10
        }
        
    +[ask]
        Answer your question and walk away #speaker:human #morality:1
- -> street

=== street ===
~ ClearEvent()
Walk to the street #background:witches #speaker:Narrator
You start feeling hungry and look for something to eat 
a#changefile:StoryTest
    -> END
