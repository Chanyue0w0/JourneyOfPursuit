// (->knot) 就是path
EXTERNAL PushEvent(a)
EXTERNAL GetEvent()
EXTERNAL ClearEvent()
// (難度, strength/agility/charisma)
EXTERNAL DiceResult(a,b)


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
You start feeling hungry and look for something to eat #changefile:StoryTest
    -> END
