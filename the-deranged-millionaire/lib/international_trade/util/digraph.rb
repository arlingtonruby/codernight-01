module InternationalTrade
  module Util
    class Digraph
      attr_reader :arcs

      def initialize(steps)
        @arcs = steps.reduce({}) do |arcs, step|
          (arcs[step.source] ||= {})[step.target] = [step]
          (arcs[step.target] ||= {})[step.source] = [step]

          arcs
        end
      end

      def path_from_to(source, target)
        paths = arcs[source].keys.reduce({}) do |p, key|
          p[key] = arcs[source][key]
          p
        end

        until paths[target]
          paths.keys.each do |path_target|
            arcs[path_target].each_pair do |arc_target, arc|
              paths[arc_target] ||= paths[path_target] + arc
            end
          end
        end

        paths[target]
      end
    end
  end
end
