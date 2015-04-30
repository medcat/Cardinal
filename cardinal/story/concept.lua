define "cardinal.story.concept":
as(function(class, instance)

  local story = cardinal.story

  function instance:initialize(id, func)
    self.id = id
    self.func = func

    self.concepts = { cells = {}, places = {}, characters = {}, actions = {},
      variables = {} }
  end

  function instance:load()
    if type(self.func) == "function" then
      self:func()
    end
  end

  function instance:flatten()
    local map = {}

    for _, concepts in pair(self.concepts) do
      for id, concept in pair(concepts) do
        map[id] = concept
        for path, value in pair(concept:flatten()) do
          map[id .. "." .. path] = value
        end
      end
    end

    return map
  end

  function instance:cell(id)
    local concept = story.concepts.cell:new(id)
    concept:load()
    self.concepts.cells[id] = concept
  end

  function instance:place(id, func)
    local concept = story.concepts.place:new(id, func)
    concept:load()
    self.concepts.places[id] = concept
  end

  function instance:character(id, func)
    local concept = story.concepts.character:new(id, func)
    concept:load()
    self.concepts.characters[id] = concept
  end

  function instance:on(id, func)
    local concept = story.concepts.action:new(id, func)
    concept:load()
    self.concepts.actions[id] = concept
  end

  function instance:variable(id, func)
    local concept = story.concepts.variable:new(id, func)
    concept:load()
    self.concepts.variables[id] = concept
  end
end)
