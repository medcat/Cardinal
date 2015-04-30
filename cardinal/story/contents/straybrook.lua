cardinal.story:add(function(story)
  story:dialog(require("cardinal.story.contents.straybrook.dialog"))
  story:place("straybrook", function(straybrook)
    straybrook:variable("introduction", false)
    straybrook:cell("southgate")

    straybrook:place("inn", function(inn)
        inn.location = "southgate"

        inn:on("stay", function() end) -- TODO

        inn:character("keeper", function(keeper)
          keeper:on("action", "dialog:intro")
        end)
    end)

    straybrook:place("store", function(store)
      store.location = "southgate"
    end)

  end)
end)
