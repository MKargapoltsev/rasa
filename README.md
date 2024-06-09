# Rasa tech task implementation
-----------------------
[![Technical task](http://i.imgur.com/aImJD4o.png)](https://gist.github.com/sanchariGr/fa0e655ed27f3810e720ac85bbecf31b)


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