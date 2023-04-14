return {
	s(
		{ trig = "useState" },
		fmt(
			[[
            const [{1}, set{2}] = useState{3}()
            ]],
			{
				i(1),
				d(2, function(args)
					return require("utils.snippit-utils").capitalise_first_letter(
						args[1][1]
					)
				end, { 1 }),
				i(3),
			}
		)
	),
	s(
		{ trig = "apicomponent" },
		fmt(
			[[
            import { useEffect, useState } from "react";

            export default function ~1@() {
              const [~2@, set~3@] =
                useState<~4@>();
              const [loading, setLoading] = useState(true);
              const [error, setError] = useState<Error>();

              useEffect(() => {
                ~5@()
                  .then((~2@Data) => {
                    setLoading(true);
                    set~3@();
                    setLoading(false);
                  })
                  .catch((error: Error) => {
                    setError(error);
                  });
              }, []);

              if (error) return <div>{{JSON.stringify(error)}}</div>;
              if (loading || !~2@) return <div>loading</div>;
              return (
                <>
                </>
              )
            }
            ]],
			{
				i(1, "Component name"),
				i(2, "API data"),
				d(3, function(args)
					return require("utils.snippit-utils").capitalise_first_letter(
						args[1][1]
					)
				end, { 2 }),
				i(4, "Type"),
				i(5, "API function"),
			},
			{
				delimiters = "~@",
				repeat_duplicates = true,
			}
		)
	),
}
