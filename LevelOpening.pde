class LevelOpening extends Level {
  LevelOpening() {
    super();
    textScene[0] = "Australia, early 1930s\n\n\nA large herd of emus have migrated towards Australian farmland.\nThe birds consumed and spoiled crops, causing the farmers to contact the Australian Military.\n\nAfter hearing of the infestation, Australian Minister of Defence, Sir George Pearce, authorized machine guns to be used on the\nemus, but only by military personnel. He promised funding from the West Australian Government, supporting the idea as it would\nbe good target practice for the men.\n\nThey sent out two men and their commander on a truck, armed with two Lewis light machine guns and 10 000 rounds of ammunition.\n\n\n\"The machine-gunners' dreams of point blank fire into serried masses of Emus were soon dissipated.\"\n\nThe Great Emu War was short lived, and became a national humiliation of the Country.";
  }

  void setupLevel() {
  }


  void update() {  
    super.update();
    if (textComplete) {
      text("Press TAB to continue.", width - 310, height - 50);
    } else {
      text("Press TAB to skip.", width - 300, height - 50);
    }
  }
}
