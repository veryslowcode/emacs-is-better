local datadir = vim.fn.stdpath("data")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = "<WORSPACE_PATH>" .. project_name

local config = {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-javaagent:" .. datadir .. "/mason/packages/jdtls/lombok.jar",
        "-jar", datadir .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
        "-configuration", datadir .. "/mason/packages/jdtls/config_<OS>",
        "-data", workspace_dir
    },
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    -- root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"}),
    settings = {
        java = {}
    },
    init_options = {
        bundles = {}
    },
}

-- Configure java-debug & vscode-java-test
local bundles = {
  vim.fn.glob(datadir .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
};

vim.list_extend(bundles, vim.split(vim.fn.glob(datadir .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n"))
config['init_options'] = {
  bundles = bundles;
}

local jdtls = require("jdtls")
jdtls.start_or_attach(config)

-- Additional keymaps for debugging tests
vim.keymap.set("n", "<leader>tC", jdtls.test_class, {desc = "[T]est [C]lass"})
vim.keymap.set("n", "<leader>tM", jdtls.test_nearest_method, {desc = "[T]est Nearest [M]ethod"})
