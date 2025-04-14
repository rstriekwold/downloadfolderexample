

*** Settings ***

Documentation                  Test suite for CRT starter.
Library                        QWeb
Library                        OperatingSystem
Library                        Collections
Suite Setup                    Open Browser                about:blank                 chrome
Suite Teardown                 Close All Browsers


*** Test Cases ***


Check on where is the download folder

    #set download folder based on EXEDIR
    IF                         "${EXECDIR}" == "/home/executor/execution"              # normal test run environment
        ${downloads_folder}=                               Set Variable                /home/executor/Downloads
    ELSE                       # Live Testing environment
        ${downloads_folder}=                               Set Variable                /home/services/Downloads
    END

    #create fil fore example
    Create File                ${downloads_folder}/test.txt                            this is a test
    @{downloads}=              List Files In Directory     ${downloads_folder}
    
    #Get the latest file in the dowload folder
    ${file}=                   Get From List               ${downloads}                0
    Log                        Filename: ${file}           console=True

    #Moving file to Outpur dir so it will be attached to the run
    Move File                  ${downloads_folder}/${file}                             ${OUTPUT_DIR}
    Sleep                      2s
    List Files In Directory    ${OUTPUT_DIR}


Check on where is the download folder with $EXECDIR
    
    #set download folder
    ${DownloadFolder}=    Set Variable    ${EXECDIR}/../Downloads
    
    #create fil fore example
    Create File                ${DownloadFolder}/testfromexedir.txt              this is a test
    @{downloads}=              List Files In Directory    ${DownloadFolder}
    
    #Get the latest file in the dowload folder
    ${file}=                   Get From List               ${downloads}                0
    Log                        Filename: ${file}           console=True

    #Moving file to Outpur dir so it will be attached to the run
    Move File                 ${DownloadFolder}/${file}                             ${OUTPUT_DIR}
    Sleep                      2s
    List Files In Directory    ${OUTPUT_DIR}
