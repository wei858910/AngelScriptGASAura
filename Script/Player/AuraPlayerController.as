class AAuraPlayerController : AAuraPlayerControllerBase
{
    UPROPERTY(Category = "输入")
    UInputMappingContext AuraContext = nullptr;

    UPROPERTY(Category = "输入")
    UInputAction MoveAction = nullptr;

    UEnhancedInputComponent MyInputComponent = nullptr;

    default bReplicates = true;

    AAuraEnemy LastEnemy = nullptr;
    AAuraEnemy ThisEnemy = nullptr;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
    {
        if (GetEnhancedInput())
        {
            BindAllAction();
        }
    }

    UFUNCTION(BlueprintOverride)
    void Tick(float DeltaSeconds)
    {
        CursorTrace();
    }

    void CursorTrace()
    {
        FHitResult HitResult;
        GetHitResultUnderCursorByChannel(ETraceTypeQuery::Visibility, false, HitResult);
        if (!HitResult.GetbBlockingHit())
        {
            return;
        }

        LastEnemy = ThisEnemy;
        ThisEnemy = Cast<AAuraEnemy>(HitResult.GetActor());

        /*
            Case	Last	This
            #1		0		0
            #2		1		0
            #3		0		1
            #4		1		1
        */
        if (LastEnemy != nullptr && ThisEnemy == nullptr)
        {
            LastEnemy.UnHightlight();
        }

        if (LastEnemy == nullptr && ThisEnemy != nullptr)
        {
            ThisEnemy.Hightlight();
        }

        if (LastEnemy != nullptr && ThisEnemy != nullptr)
        {
            if (LastEnemy != ThisEnemy)
            {
                LastEnemy.UnHightlight();
                ThisEnemy.Hightlight();
            }
        }
    }

    // 输入相关
    private bool GetEnhancedInput()
    {
        if (AuraContext != nullptr)
        {
            UEnhancedInputLocalPlayerSubsystem EnhancedInput = UEnhancedInputLocalPlayerSubsystem::Get(this);
            if (EnhancedInput != nullptr)
            {
                FModifyContextOptions Option;
                EnhancedInput.AddMappingContext(AuraContext, 0, Option);

                bShowMouseCursor = true;

                Widget::SetInputMode_GameAndUIEx(this, bHideCursorDuringCapture = false);

                MyInputComponent = UEnhancedInputComponent::Create(this);
                PushInputComponent(MyInputComponent);
                return true;
            }
        }

        return false;
    }

    private void BindAllAction()
    {
        if (MyInputComponent != nullptr)
        {
            MyInputComponent.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"Move"));
        }
    }

    UFUNCTION()
    private void Move(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction)
    {
        FRotator ControllerRotation = GetControlRotation();
        ControllerRotation.Pitch = 0.f;
        ControllerRotation.Roll = 0.f;
        FVector ControllerForwardVector = ControllerRotation.GetForwardVector();
        FVector ControllerRightVector = ControllerRotation.GetRightVector();

        APawn MyControlledPawn = GetControlledPawn();
        FVector2D MoveValue = ActionValue.GetAxis2D();
        MyControlledPawn.AddMovementInput(ControllerForwardVector, MoveValue.Y);
        MyControlledPawn.AddMovementInput(ControllerRightVector, MoveValue.X);
    }
    // 输入相关 End

    UFUNCTION(BlueprintOverride)
    void OnAcknowledgePossession(APawn P)
    {
        AAuraCharacter AuraCharacter = Cast<AAuraCharacter>(P);
        if (IsValid(AuraCharacter))
        {
            AuraCharacter.AbilitySystem.InitAbilityActorInfo(AuraCharacter, AuraCharacter);
            UAuraAttributeSet InAuraAttributeSet = Cast<UAuraAttributeSet>(AuraCharacter.AbilitySystem.RegisterAttributeSet(UAuraAttributeSet));
            AuraCharacter.SetAuraAttributeSet(InAuraAttributeSet);
            AuraUtil::GameInstance().SetWidgetControllerParams(this, PlayerState, AuraCharacter.AbilitySystem, InAuraAttributeSet);

            // 请求服务端 使用GE 进行属性初始化操作
            AuraCharacter.Server_InitializeAttributesByGameplayEffects();

            AAuraHUD AuraHUD = Cast<AAuraHUD>(GetHUD());
            if (IsValid(AuraHUD))
            {
                AuraHUD.InitOverlay();
            }
        }
    }
};