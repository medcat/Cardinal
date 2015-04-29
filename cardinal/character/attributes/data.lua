return {
  { name = "strength"     },
  { name = "luck"         },
  { name = "intelligence" },
  { name = "charisma"     },
  { name = "knowledge"    },
  { name = "energy"       },
  { name = "dexterity"    },
  { name = "speech",         value = false },
  { name = "study",          value = false },
  { name = "combat",         value = false },
  { name = "combat.weapons", value = false },
  { name = "speech.barter",             influences =
    { speech = 0, charisma = 0.75, knowledge = 0.25 } },
  { name = "speech.argue",              influences =
    { speech = 0, charisma = 0.50, intelligence = 0.35,
      knowledge = 0.15 } },
  { name = "speech.empathy",            influences =
    { speech = 0, charisma = 0.60, intelligence = 0.20,
      perception = 0.20 } },
  { name = "speech.flow",               influences =
    { speech = 0, charisma = 0.60, intelligence = 0.30,
      knowledge = 0.10 } },
  { name = "study.history",             influences =
    { study = 0, knowledge = 0.80, intelligence = 0.20 } },
  { name = "study.religion",            influences =
    { study = 0, knowledge = 0.70, energy = 0.30 } },
  { name = "study.flora",               influences =
    { study = 0, knowledge = 0.60, intelligence = 0.30,
      energy = 0.10 }, hidden = { "energy" } },
  { name = "study.fauna",               influences =
    { study = 0, knowledge = 0.60, intelligence = 0.30,
      energy = 0.10 }, hidden = { "energy" } },
  { name = "study.politics",            influences =
    { study = 0, knowledge = 0.50, charisma = 0.50 } },
  { name = "study.law",                 influences =
    { study = 0, knowledge = 0.33, intelligence = 0.34,
      charisma = 0.33 } },
  { name = "combat.tactics",            influences =
    { combat = 0, perception = 0.70, intelligence = 0.20,
      knowledge = 0.10 } },
  { name = "combat.weapons.design",     influences =
    { ["combat.weapons"] = 0, intelligence = 0.70, energy = 0.30 } },
  { name = "combat.weapons.upkeep",     influences =
    { ["combat.weapons"] = 0, intelligence = 0.60, energy = 0.30,
      strength = 0.10 }, hidden = { "strength" } },
  { name = "combat.weapons.short",     influences =
    { ["combat.weapons"] = 0, strength = 0.60, dexterity = 0.40 } },
  { name = "combat.weapons.long",       influences =
    { ["combat.weapons"] = 0, strength = 0.40, dexterity = 0.60 } },
  { name = "combat.weapons.projectile", influences =
    { ["combat.weapons"] = 0, strength = 0.30, dex = 0.30,
      perception = 0.40 } },
  { name = "magic.control",             influences =
    { magic = 0, energy = 0.60, intelligence = 0.30 } }
}
