namespace AuraUtil
{
    /**
     * 应用游戏效果到目标Actor
     * @param SourceActor 效果来源Actor
     * @param TargetActor 效果目标Actor
     * @param GameplayEffectclass 要应用的游戏效果类
     * @param Level 效果等级，默认为1
     * @return 激活的游戏效果句柄，可用于后续移除效果
     */
    FActiveGameplayEffectHandle ApplyGameEffect(AActor SourceActor, AActor TargetActor, TSubclassOf<UGameplayEffect> GameplayEffectclass, float32 Level = 1)
    {
        // 获取目标Actor的能力系统组件
        UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(TargetActor);
        // 如果能力系统组件不存在，返回空句柄
        if (TargetASC == nullptr)
        {
            return AuraConst::EmptyEffectHandle;
        }

        // 确保游戏效果类不为空（调试检查）
        check(GameplayEffectclass != nullptr);
        // 创建效果上下文句柄
        FGameplayEffectContextHandle EffectContextHandle = TargetASC.MakeEffectContext();
        // 设置效果来源对象
        EffectContextHandle.AddSourceObject(SourceActor);
        // 创建效果规格句柄
        FGameplayEffectSpecHandle EffectSpecHandle = TargetASC.MakeOutgoingSpec(GameplayEffectclass, Level, EffectContextHandle);
        // 将效果应用到自身并返回句柄
        return TargetASC.ApplyGameplayEffectSpecToSelf(EffectSpecHandle);
    }

    /**
     * 从目标Actor移除游戏效果
     * @param TargetActor 要移除效果的目标Actor
     * @param EffectHandle 要移除的效果句柄
     * @param StacksToRemove 要移除的堆叠数量，-1表示移除所有堆叠
     * @return 移除操作是否成功
     */
    bool RemoveGameplayEffect(AActor TargetActor, FActiveGameplayEffectHandle EffectHandle, int StacksToRemove = -1)
    {
        // 获取目标Actor的能力系统组件
        UAbilitySystemComponent TargetASC = AbilitySystem::GetAbilitySystemComponent(TargetActor);
        // 如果能力系统组件不存在，返回false
        if (TargetASC == nullptr)
        {
            return false;
        }

        // 移除指定的激活游戏效果
        return TargetASC.RemoveActiveGameplayEffect(EffectHandle, StacksToRemove);
    }

    float SafeDivide(float A, float B)
    {
        return (B != 0.0f) ? (A / B) : 0.0f;
    }

    float32 SafeDivide(float32 A, float32 B)
    {
        return (B != 0.0f) ? (A / B) : 0.0f;
    }

} // namespace AuraUtil