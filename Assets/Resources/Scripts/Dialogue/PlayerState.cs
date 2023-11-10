using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class PlayerState
{
    public int HP;
    public int money;
    public int morality;
    public int strength;
    public int agility;
    public int charisma;

    public PlayerState()
    {
        HP = 100;
        money = 0;
        morality = 0;
        strength = 10;
        agility = 10;
        charisma = 10;
    }

    public void UpdatePlayerState(Text HP, Text money, Text strength, Text agility, Text charisma)
    {
        HP.text = "HP: " + this.HP.ToString();
        money.text = "Money: " + this.money.ToString();  
        strength.text = "Strength: " + this.strength.ToString();
        agility.text = "Agility: " + this.agility.ToString();
        charisma.text = "Charisma: " + this.charisma.ToString();
    }
}
