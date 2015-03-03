[CODE]
#ifdef UNICODE
  #define AW "W"
#else
  #define AW "A"  
#endif

//Constants
const
  INFINITE=                   $FFFFFFFF;

//SHELLEXECUTEINFO Masks
  SEE_MASK_DEFAULT=           $00000000;
  SEE_MASK_NOASYNC=           $00000100;
  SEE_MASK_NO_CONSOLE=        $00008000;
  SEE_MASK_ASYNCOK=           $00100000;
  SEE_MASK_WAITFORINPUTIDLE=  $02000000;
  SEE_MASK_NOCLOSEPROCESS=    $00000040;

//Type definitions for Win Api calls
type
  TScAction = record
  aType1 : Longword;
  Delay1 : Longword;
  aType2 : Longword;
  Delay2 : Longword;
  aType3 : Longword;
  Delay3 : Longword;
end;

type
  LPVOID = record
  dwResetPeriod : DWORD;
  pRebootMsg : String;
  pCommand : String;
  cActions : DWORD;
  saActions : TScAction;
end;

type
  LPPROCESS_INFORMATION  = record
  hProcess : THandle;
  hThread : THandle;
  dwProcessId : DWORD;
  dwThreadId : DWORD;
end;

type
  TShellExecuteInfo = record
    cbSize: DWORD;
    fMask: Cardinal;
    HWND: HWND;
    lpVerb: string;
    lpFile: string;
    lpParameters: string;
    lpDirectory: string;
    nShow: Integer;
    hInstApp: THandle;    
    lpIDList: DWORD;
    lpClass: string;
    hkeyClass: THandle;
    dwHotKey: DWORD;
    hMonitor: THandle;
    hProcess: THandle;
end;

type
  LPSTARTUPINFO = record
  cb : DWORD;
  lpReserved : String; 
  lpDesktop : String;  
  lpTitle : String;                                                                    
  dwX:DWORD;
  dwY:DWORD;
  dwXSize:DWORD;
  dwYSize:DWORD;
  dwXCountChars : DWORD;
  dwYCountChars : DWORD;
  dwFillAttribute : DWORD;
  dwFlags : DWORD;
  wShowWindow : WORD;
  cbReserved2 : WORD;
  lpReserved2 : BYTE;
  hStdInput : Thandle;
  hStdOutput : Thandle;
  hStdError : Thandle;
end;

type 
  LPSECURITY_ATTRIBUTES = record
  nLength : DWORD;
  lpSecurityDescriptor : LPVOID;
  bInheritHandle : BOOL;
end;


//Function definitions
function AssignProcessToJobObject(
  var hJob : Thandle;
  var hProcess : Thandle
  ): BOOL;
external 'AssignProcessToJobObject@kernel32.dll stdcall';

function CreateJobObject(
  lpSecurityAttributes : LPSECURITY_ATTRIBUTES;
  lpName: String
  ): THandle;
external 'CreateJobObject{#AW}@kernel32.dll stdcall';

function CreateProcess(
  lpApplicationName : String;
  lpCommandLine : String;
  lpSecurityAttributes : LPSECURITY_ATTRIBUTES;
  lpThreadAttributes : LPSECURITY_ATTRIBUTES;
  bInheritHandles : BOOL;
  dwCreationFlags: DWORD;
  var lpEnvironment : LPVOID;
  const lpCurrentDirectory : String;
  lpStartupInfo : LPSTARTUPINFO;
  out lpProcessInformation : LPPROCESS_INFORMATION
  ): BOOL;
external 'CreateProcess{#AW}@kernel32.dll stdcall';

procedure ExitProcess(
  exitCode : Integer
  );
external 'ExitProcess@kernel32.dll stdcall';

function ShellExecute(
  hwnd : HWND;
  lpOperation : String;
  lpFile : String;
  lpParameters : String;
  lpDirectory : String;
  nShowCmd : Integer
  ): Thandle;
external 'ShellExecute{#AW}@Shell32.dll stdcall';

function ShellExecuteEx(
  var lpExecInfo: TShellExecuteInfo
  ): BOOL; 
external 'ShellExecuteEx{#AW}@Shell32.dll stdcall';

function SetEnvironmentVariable(
  lpName: string;
  lpValue: string
  ): Boolean;
external 'SetEnvironmentVariable{#AW}@kernel32.dll stdcall';

function SuspendThread(
  hThread : Thandle
  ): DWORD;
external 'SuspendThread@kernel32.dll stdcall';

function SignalObjectAndWait(
  hObjectToSignal : Thandle;
  hObjectToWaitOn : Thandle;
  dwMilliseconds : DWORD;
  bAlertable : BOOL
) : DWORD;
external 'SignalObjectAndWait@Kernel32.dll stdcall';

function ResumeThread (
  hThread : Thandle
  ) : DWORD;
external 'ResumeThread@kernel32.dll stdcall';

function GetProcessHandleFromHwnd(
  hwnd : HWND
) : Thandle;
external 'GetProcessHandleFromHwnd@Oleacc.dll stdcall';

function GetProcessId(
  Process : Thandle
) : DWORD;
external 'GetProcessId@Kernel32.dll stdcall';

function GetExitCodeProcess(
  hProcess : Thandle;
  var lpExitCode : DWORD
) : Boolean;
external 'GetExitCodeProcess@Kernel32.dll stdcall';

function GetLastError(
  ) : DWORD;
external 'GetLastError@Kernel32.dll stdcall';

function InitializeSecurityDescriptor(
  var pSecurityDescriptor : LPVOID;
  dwRevision : DWORD
) : BOOL;
external 'InitializeSecurityDescriptor@Advapi32.dll stdcall';

function WaitForSingleObject(
  hHandle : THandle;
  dwMilliseconds : DWORD
  ) : DWORD;
external 'WaitForSingleObject@kernel32.dll stdcall';

function WaitForSingleObjectEx(
  hHandle : THandle;
  dwMilliseconds : DWORD;
  bAlertable : Boolean
  ) : DWORD;
external 'WaitForSingleObjectEx@kernel32.dll stdcall';
 
function GetTickCount: DWord; 
external 'GetTickCount@kernel32 stdcall';