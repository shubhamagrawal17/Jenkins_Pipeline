properties([
    buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '20')),
    disableConcurrentBuilds(),
    parameters([
        string(defaultValue: 'Northwind', description: 'DB Name', name: 'DB_Name'),
        string(defaultValue: '192.168.0.106', description: 'DB Server', name: 'dbServer')
        ])
    ])
node('Windows') {
    try {

        stage ('Run DB Script') {  
            withCredentials([usernamePassword(credentialsId: 'DB_Cred', passwordVariable: 'MOS_DB_PASS', usernameVariable: 'MOS_DB_USER')]) {
                
                steps: {
                        withEnv(["VAR_DBSERVER=${params.dbServer}", "VAR_DBNAME=${params.DB_Name}", "VAR_DBUSER=${MOS_DB_USER}", "VAR_DBPASSWORD=${MOS_DB_PASS}"]) {
                            
                                powershell script: '''
                                    $Categories = Invoke-Sqlcmd -ServerInstance $($env:VAR_DBSERVER) -Database $($env:VAR_DBNAME) -Username $($env:VAR_DBUSER) -Password $($env:VAR_DBPASSWORD) -Query "select *from dbo.Categories" -Querytimeout 600 -Verbose -ErrorAction Continue
                                    $Categories.CategoryName   
                                    '''
                            
                        }
                    }
                steps: {
                        withEnv(["VAR_DBSERVER=${params.dbServer}", "VAR_DBNAME=${params.DB_Name}", "VAR_DBUSER=${MOS_DB_USER}", "VAR_DBPASSWORD=${MOS_DB_PASS}"]) {
                            
                                powershell script: '''
                                    $Employees = Invoke-Sqlcmd -ServerInstance $($env:VAR_DBSERVER) -Database $($env:VAR_DBNAME) -Username $($env:VAR_DBUSER) -Password $($env:VAR_DBPASSWORD) -Query "select *from dbo.Employees" -Querytimeout 600 -Verbose -ErrorAction Continue
                                    $Employees.FirstName   
                                    '''
                            
                        }
                    }     
            }
        }
  
    }
    catch (exception) {
        currentBuild.result = "FAILURE"
        errorMessage = exception.getMessage()
    }
}
