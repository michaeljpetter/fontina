module Fontina

  QualifiedName = Mores::ImmutableStruct.new(
    *%i[name platform language],
    strict: true
  )

  Font = Mores::ImmutableStruct.new(
    *%i[names family_names type points weight italic underline strikeout],
    strict: true
  )

  Package = Mores::ImmutableStruct.new(
    *%i[names fonts],
    strict: true
  )

end
