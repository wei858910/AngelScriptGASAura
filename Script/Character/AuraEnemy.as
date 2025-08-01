class AAuraEnemy : AAuraCharacterBase
{
    default Mesh.SetCollisionResponseToChannel(ECollisionChannel::ECC_Visibility, ECollisionResponse::ECR_Block);
};