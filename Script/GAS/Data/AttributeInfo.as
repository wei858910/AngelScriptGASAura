
USTRUCT()
struct FAuraAttributeInfo
{
	UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)
	FGameplayTag AttributeTag = FGameplayTag();

	UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)
	FText AttributeName = FText();

	UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)
	FText AttributeDescription = FText();

	UPROPERTY(NotEditable, BlueprintReadOnly)
	float32 AttributeValue = 0.f;
}

class UAttributeInfo : UDataAsset
{

	UPROPERTY(EditDefaultsOnly, BlueprintReadOnly)
	TArray<FAuraAttributeInfo> AttributeInformation;

	FAuraAttributeInfo FindAttributeInfoForTag(const FGameplayTag& AttributeTag, bool bLogNotFound = false)
	{
		for (const FAuraAttributeInfo& Info : AttributeInformation)
		{
			if (Info.AttributeTag.MatchesTagExact(AttributeTag))
			{
				return Info;
			}
		}

		if (bLogNotFound)
		{
			Print(f"Can't find Info fo AttributeTag [{AttributeTag.ToString()}] on AttributeInfo [{this.GetName()}]");
		}

		return FAuraAttributeInfo();
	}
};