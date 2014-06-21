Function Function-Template {
<#
.SYNOPSIS  
		Synopsis goes here

.DESCRIPTION  
		Description goes here

.LINK  
    http://link.com
                
.NOTES  
    Version:		        0.x
  
    Author/Copyright:	  Copyright Tom Arbuthnot - All Rights Reserved
    
    Email/Blog/Twitter:	tom@tomarbuthnot.com tomarbuthnot.com @tomarbuthnot
    
    Disclaimer:   	    THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND. THE ENTIRE RISK
                        OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.
                        While these scripts are tested and working in my environment, it is recommended 
                        that you test these scripts in a test environment before using in your production 
                        environment. Tom Arbuthnot further disclaims all implied warranties including, 
			                  without limitation, any implied warranties of merchantability or of fitness for 
			                  a particular purpose. The entire risk arising out of the use or performance of 
			                  this script and documentation remains with you. In no event shall Tom Arbuthnot, 
			                  its authors, or anyone else involved in the creation, production, or delivery of 
			                  this script/tool be liable for any damages whatsoever (including, without limitation, 
                        damages for loss of business profits, business interruption, loss of business 
			                  information, or other pecuniary loss) arising out of the use of or inability to use 
			                  the sample scripts or documentation, even if Tom Arbuthnot has been advised of 
			                  the possibility of such damages.
    
     
    Acknowledgements: 	
    
    Assumptions:	      ExecutionPolicy of AllSigned (recommended), RemoteSigned or Unrestricted (not recommended)
    
    Limitations:		  										
    		
    Ideas/Wish list:	
    
    Rights Required:	

    Known issues:	


.EXAMPLE
		Function-Template
 
		Description
		-----------
		Returns Objects

.EXAMPLE
		Function-Template -Param1
 
		Description
		-----------
		Actions Param1

# Parameters

.PARAMETER Param1
		Param1 description

.PARAMETER Param2
		Param2 Description
		

#>
  
  
  #############################################################
  # Param Block
  #############################################################
  
  # Sets that -Whatif and -Confirm should be allowed
  [cmdletbinding(SupportsShouldProcess=$true)]
  
  Param 	(
    [Parameter(Mandatory=$false,
    HelpMessage='Param1 Description')]
    $Param1 = 'defaultvalue1',
    
    
    [Parameter(Mandatory=$false,
    HelpMessage='Param2 Description')]
    $Param2 = 'defaultvalue1',
    
    
    [Parameter(Mandatory=$false,
    HelpMessage='Error Log location, default C:\<Command Name>_ErrorLog.txt')]
    [string]$ErrorLog = "c:\$($myinvocation.mycommand)_ErrorLog.txt",
    [switch]$LogErrors
    
  ) #Close Parameters
  
  
  #############################################################
  # Begin Block
  #############################################################
  
  Begin 	{
    Write-Verbose "Starting $($myinvocation.mycommand)"
    Write-Verbose "Error log will be $ErrorLog"
    
    # Script Level Variable to Stop Execution if there is an issue with any stage of the script
    $script:EverythingOK = $true
    
 
  } #Close Function Begin Block
  
  #############################################################
  # Process Block
  #############################################################
  
  Process {
    
    # First Code To Run
    If ($script:EverythingOK)
    {
      Try 	
      {
        
        # Code Goes here
        
        
      } # Close Try Block
      
      Catch 	{ErrorCatch-Action} # Close Catch Block
      
      
    } # Close If EverthingOK Block 1
    
    #############################################################
    # Next Script Action or Try,Catch Block
    #############################################################
    
    # Second Code To Run
    If ($script:EverythingOK)
    {
      Try 	
      {
        
        # Code Goes here
        
        
      } # Close Try Block
      
      Catch 	{ErrorCatch-Action} # Close Catch Block
      
      
    } # Close If EverthingOK Block 2
    
    
  } #Close Function Process Block 
  
  #############################################################
  # End Block
  #############################################################
  
  End 	{
    Write-Verbose "Ending $($myinvocation.mycommand)"
  } #Close Function End Block
  
} #End Function



# Helper Functions below this line ##########################################


    #############################################################
    # Function to Deal with Error Output to Log file
    #############################################################
    

 Function ErrorCatch-Action 
    {
      Param 	(
        [Parameter(Mandatory=$false,
        HelpMessage='Switch to Allow Errors to be Caught without setting EverythingOK to False, stopping other aspects of the script running')]
        # By default any errors caught will set $EverythingOK to false causing other parts of the script to be skipped
        [switch]$SetEverythingOKVariabletoTrue
      ) # Close Parameters
      
      # Set EverythingOK to false to avoid running dependant actions
      If ($SetEverythingOKVariabletoTrue) {$script:EverythingOK = $true}
      else {$script:EverythingOK = $false}
      Write-Verbose "EverythingOK set to $script:EverythingOK"
      
      # Write Errors to Screen
      Write-Error $Error[0]
      # If Error Logging is runnning write to Error Log
      
      if ($LogErrors) {
        # Add Date to Error Log File
        Get-Date -format 'dd/MM/yyyy HH:mm' | Out-File $ErrorLog -Append
        $Error | Out-File $ErrorLog -Append
        '## LINE BREAK BETWEEN ERRORS ##' | Out-File $ErrorLog -Append
        Write-Warning "Errors Logged to $ErrorLog"
        # Clear Error Log Variable
        $Error.Clear()
      } #Close If
    } # Close Error-CatchActons Function