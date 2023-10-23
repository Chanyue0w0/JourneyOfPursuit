using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerState
{
    public int HP;
    public int morality;
    public int strength;
    public int agility;
    public int charisma;

    public PlayerState()
    {
        HP = 100;
        morality = 0;
        strength = 10;
        agility = 10;
        charisma = 10;
    }
}
