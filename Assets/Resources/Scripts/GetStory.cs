using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FileStream : System.IO.Stream

public class GetStory : MonoBehaviour
{
    Playerdata
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetKeyDown(Keycode,space)){
            FileStream fs = new FileStream(Application.dataPath,"/journeys/journey1.json",FileMode.Open);
            StreamReader sr = new StreamReader(fs);
            data.story = 

        }
    }
}
