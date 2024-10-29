--!strict

local fs = require("@lune/fs")
local serde = require("@lune/serde")

type Target = {
	environment: string,
	lib: string,
	bin: string?,
	build_files: { string }?,
}

local TARGETS: { [string]: Target } = {
	luau = {
		environment = "luau",
		lib = "lib.luau",
		bin = "bin.luau",
	},
	lune = {
		environment = "lune",
		lib = "lib.luau",
		bin = "bin.luau",
	},
	roblox = {
		environment = "roblox",
		lib = "lib.luau",
		build_files = { "lib.luau" },
	},
}

local baseManifest = fs.readFile("pesde-base.toml")
local binScript = fs.readFile("bin.luau")
local libTemplate = fs.readFile("lib.luau")

local manifest = serde.decode("toml", baseManifest)

if fs.isDir("build") then
	fs.removeDir("build")
end
fs.writeDir("build")

for targetName, target in TARGETS do
	local outDir = `build/{targetName}`

	fs.writeDir(outDir)

	local includes = {
		"pesde.toml",
		"README.md",
		"LICENSE",
		"docs",
	}

	fs.copy("LICENSE", `{outDir}/LICENSE`)
	fs.copy("README.md", `{outDir}/README.md`)
	fs.copy("docs", `{outDir}/docs`)

	if target.lib then
		local message = `Hello, pesde! ({manifest.name}@{manifest.version}, {targetName})`
		local file = string.gsub(libTemplate, "<< PRINT MESSAGE >>", message)

		fs.writeFile(`{outDir}/{target.lib}`, file)
		table.insert(includes, target.lib)
	end

	if target.bin then
		fs.writeFile(`{outDir}/{target.bin}`, binScript)
		table.insert(includes, target.bin)
	end

	local targetSection = serde.encode("toml", { target = target }, true)
	local includesSection = serde.encode("toml", { includes = includes }, true)

	local manifestFile = baseManifest
	manifestFile ..= "\n" .. targetSection
	manifestFile = string.gsub(manifestFile, "includes = %[%]\n", includesSection)

	fs.writeFile(`{outDir}/pesde.toml`, manifestFile)
end
