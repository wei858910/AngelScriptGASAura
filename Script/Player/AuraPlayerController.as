class AAuraPlayerController : APlayerController
{
    UPROPERTY(Category = "输入")
    UInputMappingContext AuraContext;

    UPROPERTY(Category = "输入")
    UInputAction MoveAction;

    default bReplicates = true;

    UFUNCTION(BlueprintOverride)
    void BeginPlay()
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

                SetupInputComponent();
            }
        }
    }

    void SetupInputComponent()
    {
        auto MyInputComponent = UEnhancedInputComponent::Create(this);
        PushInputComponent(MyInputComponent);

        MyInputComponent.BindAction(MoveAction, ETriggerEvent::Triggered, FEnhancedInputActionHandlerDynamicSignature(this, n"Move"));
    }

    UFUNCTION()
    void Move(FInputActionValue ActionValue, float32 ElapsedTime, float32 TriggeredTime, const UInputAction SourceAction)
    {
        FRotator ControllerRotation = GetControlRotation();
        ControllerRotation.Pitch = 0.f;
        ControllerRotation.Roll = 0.f;
        FVector ControllerForwardVector = ControllerRotation.GetForwardVector();
        FVector ControllerRightVector = ControllerRotation.GetRightVector();

        APawn     MyControlledPawn = GetControlledPawn();
        FVector2D MoveValue = ActionValue.GetAxis2D();
        MyControlledPawn.AddMovementInput(ControllerForwardVector, MoveValue.Y);
        MyControlledPawn.AddMovementInput(ControllerRightVector, MoveValue.X);
    }
};