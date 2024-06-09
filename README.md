# Rasa tech task implementation
-----------------------
[![Technical task](https://app.ashbyhq.com/api/images/org-theme-wordmark/f2967945-f798-41ce-ab41-cee387dab696/95f8882b-ddbd-4e24-bc04-c1d37f927131.png)](https://gist.github.com/sanchariGr/fa0e655ed27f3810e720ac85bbecf31b)

[![SERVREST API](https://img.shields.io/badge/API-ServeRest-brightgreen)](https://github.com/PauloGoncalvesBH/ServeRest/)

**Project structure**
rasa
├── .github
│   ├── workflows
│   │   ├── robot-framework.yml
├── tests
│   ├── keywords
│   │   ├── common.resource
│   ├── automated_API_tests.robot
│   ├── automated_CLI_tests.robot
│   ├── general.resource
├── .gitattributes
├── .gitignore
├── README.md
├── requirements.txt


**Activate the virtual environment**
```
source rasa-env/bin/Activate
```

**Install all packages**
```
pip3 install -r requirements.txt
```

**Install Task warrior**
```
brew install task
```

**Test execution**
```
python -m robot --outputdir reports tests
```