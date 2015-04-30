return {
--[[
-- In the beginning, the main character walks in to a small town on the
-- outskirts of a large city near the border of a country.
--
-- The main character moves in from the south.  The main character stops by an
-- inn and a store; the inn is too the left, the store is too the right.  Grass
-- surrounds both, seperated by a paved dirt road.  The inn is rather large,
-- but the store is average size.
--
-- A cry for help eminates from the northern side.  The player has control now.
-- The player has a few options:
--
-- a. the primary option is to go towards the source of the noise.  In this
--    case, the player will move north; what happens next is another set of
--    options not shown here.
-- b. the player may go into the inn.  Going into the inn and just talking to
--    the shopkeep is a free action.
--    There is no penalty for going to the inn.
-- c. the player may go into the shop.  The player will have no money, and
--    therefore will not be able to purchase anything.  Going into the shop is
--    a free action, no matter what action the player takes in the shop.
--    There is no penalty for going to the shop.
-- d. the player may attempt to leave via the southgate.  The player will be
--    stopped by a guard that is raising the gate; since it is sundown, the
--    gate must be closed.
--    There is no penalty for attempting to leave.
--]]

  [".straybrook.inn.keeper.intro"] = {
    includes = { ".player", ".straybrook.inn.keeper" },
    dialog   = {
      { type     = "say",
        source   = ".straybrook.inn.keeper",
        emotion  = "happy",
        text     = [[Welcome to the Stout Mare!  How can I help you today?]],
        next     = 2 },
      { type     = "choice",
        title    = "What do you do?",
        options  = {
          { text = "Sleep", next = "action:.straybrook.inn.stay" },
          { text = "Ask about the call for help",
            next = 3, condition = ".straybrook.introduction" },
          { text = "Exit", next = "exit:" } } },
      { type     = "say",
        source   = ".straybrook.inn.keeper",
        emotion  = "confused",
        text     = [[Call for help?  I don't remember hearing a call for ]] ..
                   [[help...  The walls in the inn are thick, though, so ]] ..
                   [[it could be I just didn't hear it.]] }
    } },
  [".straybrook.store.keeper.info"] = {
    includes = { ".player", ".straybrook.store.keeper" },
    dialog   = {
      { type     = "say",
        source   = ".straybrook.store.keeper",
        emotion  = "neutral",
        text     = [[Welcome to my shop.  Buy something.  Please.]],
        next     = 1 },
      { type     = "choice",
        title    = "What do you do?",
        options  = {
          { text = "Buy",  next = "action:.straybrook.store.buy" },
          { text = "Sell", next = "action:.straybrook.store.sell" },
          { text = "Exit", next = "exit:" }
        } }
    } },

--[[
-- If the player progresses north, without spending time in southgate, then
-- they will encounter a crowd of people.  One of them stands out, a "concerned
-- citizen"; if the player goes up to talk to the citizen, they will tell the
-- what happened - the player will then have a choice.  Help the victim, or
-- wait for one of the guards to help the victim.
-- The player can also charge and fight the attacker, a creature of death.
--
-- options when north:
-- a. if the player did not spend time in southgate, and the player talked to
--    the concerned citizen, the player may choose to fight the attacker.
--    There is no penalty for this option.  However, a bonus may be applied to
--    the relationship with the victim.
-- b. if the player did not spend time in southgate, and the player talked to
--    the concerned citizen, the player may choose to wait for a guard.
--    There is no penalty for this option.  No bonus will be applied to the
--    relationship with the victim.
-- c. if the player did not spend time in southgate, and the player chooses not
--    to talk to the concerned citizen, the player may fight the attacker.
--    There is no penalty for this option.  However, a large bonus may be
--    applied to the relationship with the victim.
--]]

  [".straybrook.intro.concernedCitizen"] = {
    includes = { ".player", ".straybrook.concernedCitizen" },
    dialog   = {
      { type    = "say",
        source  = ".straybrook.concernedCitizen",
        emotion = "shocked",
        text    = [[I... I can't believe it!  That... creature came out ]] ..
                  [[of nowhere, and attacked \pronoun{.straybrook.victim}{her}{him}!]] ..
                  [[I would help, but there's not much I can do...]],
        next    = 1 },
      { type    = "choice",
        title   = "You have a choice...",
        options = {
          { text = [[[Help \pronoun{.straybrook.victim{her}{him}}]], next = "action:.straybrook.intro.help" ]}
        } }
    }
  }
}
