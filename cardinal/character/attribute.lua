define "cardinal.character.attribute":
as(function(class, instance)

  -- The full name of the attribute.
  instance.name = ""

  -- The list of attributes that influence this attribute.  The keys
  -- are the attributes, and the values are the amount that it
  -- influences this attribute.
  instance.influences = {}

  -- The list of influences that are hidden; i.e., not shown to the
  -- user.  This is an array.
  instance.hidden = {}

  -- Whether or not the attribute actually has a value; i.e., is not
  -- a category.
  instance.value = true

  function instance:initialize(data)
    if type(data) ~= "table" then error("expected table") end
    self._data      = data
    self.name       = data.name or ""
    self.influences = data.influences or {}
    self.hidden     = data.hidden or {}
    self.value      = data.value
  end
end)
