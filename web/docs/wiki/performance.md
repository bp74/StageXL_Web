In Flash all DisplayObjects share the the same stage. With dartflash you can use multiple layers of stages. The advantage with this approach is that you can add your DisplayObjects to different stages (and therefore display lists). You will get better performance as soon as you can suspend the render loop on one of those stages (eg. the background of a game).

### Details ###

Use two canvas elements on top of each other. One for the background of your game, the other for the foreground.
 
    <div style="position: relative; ">
      <canvas id="stageBackground" width="800" height="600" style="position: absolute; left: 0; top: 0; z-index: 0;"></canvas>
      <canvas id="stageForeground" width="800" height="600" style="position: absolute; left: 0; top: 0; z-index: 1;"></canvas>
    </div>


Now create two Stages out of those 2 canvas elements and set the "renderMode" property:

	Stage stageBackground = new Stage("StageBackground", document.query('#stageBackground'));
	Stage stageForeground = new Stage("StageForeground", document.query('#stageForeground'));
	
	stageBackground.renderMode = StageRenderMode.STOP;
	stageForeground.renderMode = StageRenderMode.AUTO;
	
In this sample the render loop will NOT render the background. Only the foreground will be rendered on every frame. If you want to change the content of the background you just set the "renderMode" to ONCE and the render loop will render the background on the next frame - but just once :)

	stageBackground.renderMode = StageRenderMode.ONCE;

