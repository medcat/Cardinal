define "cardinal.story.concepts.story": extends "cardinal.story.concept":
as(function(class, instance)

  self.dialogs = nil

  function instance:initialize()
    self.dialogs = {}
    self.super.initialize(self)
  end

  function instance:dialog(dialog)
    table.insert(self.dialogs, dialog)
  end
end)
