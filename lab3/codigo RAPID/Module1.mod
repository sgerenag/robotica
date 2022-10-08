MODULE Module1
        CONST robtarget Target_10:=[[33.774,45.986,-30],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_20:=[[33.774,45.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_30:=[[72.315,103.626,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_40:=[[72.315,145.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_50:=[[85.548,145.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_60:=[[85.548,103.626,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_70:=[[125.452,45.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_80:=[[110.036,45.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_90:=[[79.75,93.053,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_100:=[[49.873,45.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_110:=[[33.774,45.986,0],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_120:=[[33.774,45.986,-30],[1,0.000000014,-0.000000061,0.000000071],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_5:=[[796.096,538.936,-704.132],[0.241844762,0.664463024,-0.241844762,0.664463024],[-1,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_150:=[[637.28,73.58,604.04],[0.469925,-0.171754,0.813662,0.296016],[0,-1,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_140:=[[127.245,721.398,712],[0.221342095,-0.288199838,0.443971893,0.819046695],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    CONST robtarget Target_inter:=[[-167.886,926.07,561.923],[0.516607902,-0.850021862,-0.000000001,0.102854802],[1,-2,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
!***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: Daniel
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        WHILE TRUE DO
            WaitDI DI_01,1;
            instpose;
            WaitDI DI_02,1;
            Set DO_01;
            pathY;
            Reset DO_01;
        ENDWHILE
    ENDPROC
    PROC pathY()
        MoveJ Target_10,v100,z10,marctoolTCP\WObj:=miwobj;
        MoveL Target_20,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_30,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_40,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_50,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_60,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_70,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_80,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_90,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_100,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveL Target_110,v50,z0,marctoolTCP\WObj:=miwobj;
        MoveJ Target_120,v100,z10,marctoolTCP\WObj:=miwobj;
        MoveJ Target_inter,v300,z200,marctoolTCP\WObj:=wobj0;
        MoveJ Target_150,v300,z100,marctoolTCP\WObj:=wobj0;
    ENDPROC
    PROC instpose()
        MoveJ Target_150,v300,z100,marctoolTCP\WObj:=wobj0;
        MoveJ Target_140,v300,z100,marctoolTCP\WObj:=wobj0;
    ENDPROC
    PROC gohome()
        MoveJ Target_150,v300,z100,marctoolTCP\WObj:=wobj0;
    ENDPROC
ENDMODULE