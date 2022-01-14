# pre-commit-hooks-nodejs-reactjs


* The pre-commit hooks I have code will help to find High and Critical Vulnerabilities, if find, commit will be discarded.
* Also Validate branch names, this will not let you to push changes to bad naming branches.
* 

# steps to use pre-commit hooks on your nodejs project, can be used in React Js projects
copy and paste ./scripts folder into your porject in root path.
in package.json, add this lines scripts section 
> "postinstall": "shx echo 'Installing hooks...' && shx cp ./scripts/pre-commit.bash .git/hooks/pre-commit"

also need to install `shx` npm module as Dev dependency
###### install pre-commit hooks
> npm i

