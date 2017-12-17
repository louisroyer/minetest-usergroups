usergroups = {}
groups = {}


usergroups.modpath = minetest.get_modpath("usergroups")

filepath = minetest.get_worldpath().."/usergroups.dat"

function usergroups:save()
    datastr = minetest.serialize(groups)

    local file, err = io.open(filepath, "w")
    if err then
        return err
    end
    file:write(datastr)
    file:close()
end



minetest.register_chatcommand("usergroups_add", {
    params = "<group> <user>",
    description = "Add a user to a group",
    privs = {["server"] = true},
    func = function(name, param)
        local group, user = param:match('^(%S)%s(%S)$')
        groups = {[group] = {[user]=true}}
        usergroups:save()
    end
})
