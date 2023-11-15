LCLChapter = CustomItem:extend()

function LCLChapter:init(ch, items)
    self.code = "ch"..ch.."_lcl"
    self.items = items
end 
