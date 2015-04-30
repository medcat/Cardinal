define "cardinal.story": type "module":
as(function(module)
  function module:add(func)
    self.contents = self.contents or cardinal.story.concepts.story:new("cardinal")
    func(self)
  end
end)

require "cardinal.story.concept"
require "cardinal.story.concepts"
