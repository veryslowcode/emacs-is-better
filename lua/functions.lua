vim.g.dotnet_build = function()
    local project = vim.g["dotnet_last_path"]
    if project == nil then
        project = vim.fn.getcwd() .. "/"
    end

    local path = vim.fn.input("Project path: ", project, "file")
    vim.g["dotnet_last_path"] = path

    local command = "dotnet build -c debug " .. path

    print("")
    print("Command: " .. command)

    local result = os.execute(command)
    if result == 0 then
        print("\nBuild: ✔️")
    else
        print("\nBuild: ❌")
    end
    return result
end
